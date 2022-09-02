import json
from abc import ABC, abstractmethod

import requests
from requests.exceptions import HTTPError
from datetime import datetime

from skale.utils.web3_utils import to_checksum_address

import update_delegations

from config import ENDPOINT, ABI_FILEPATH, ALLOC_ABI_FILEPATH, PROXY_ADMIN_ABI_FILEPATH

from skale.utils.helper import init_default_logger, get_abi

from web3 import Web3

import logging

logger = logging.getLogger(__name__)
now = datetime.now()
init_default_logger()

w3 = Web3(Web3.HTTPProvider(ENDPOINT))
manager_abi = get_abi(ABI_FILEPATH)
allocator_abi = get_abi(ALLOC_ABI_FILEPATH)
proxy_admin_abi = get_abi(PROXY_ADMIN_ABI_FILEPATH)


class MainCreator(ABC):

    @abstractmethod
    def parameters(self, tx, contract_id, cont_address, contract_function_name, contract_parameters,
                   implementation_address):
        pass

    @abstractmethod
    def api_link(self, cont_address, high_watermark):
        pass

    @abstractmethod
    def proxy_contract_executable(self):
        pass

    @abstractmethod
    def upsert_values(self, values_to_insert, last_block_num, contract_id, contract_table):
        pass

    def transaction_load(self, record) -> bool:
        contract_id = record[0]
        cont_address = record[1]
        cont_name = record[3]
        repo = record[4]
        implementation = ""
        holder_of_escrow = ""
        if len(record) > 6:
            implementation = record[6]
        if len(record) > 7:
            holder_of_escrow = record[7]
        high_watermark = self.get_high_watermark(record)

        logger.info(f'Loading Transactions. contract name {cont_name} and address {cont_address} of {repo} '
                     f'with high_watermark {high_watermark}')

        cont_table = '`skale_contract`'
        if not self.proxy_contract_executable and 'proxy_contract' in cont_name:
            logger.info(f'Skipping internal tx load for proxy_contract {cont_name}')

            return False

        try:
            api_call = self.api_link(cont_address, high_watermark)
            logger.info(f'api_call : {api_call}')
            d3 = self.get_response(api_call)

            if "proxy_contract" in cont_name and len(d3) == 0:
                api_call = self.api_link(holder_of_escrow, high_watermark)
                logger.info(f'holder_transactions : {api_call}')
                d3 = self.get_response(api_call)

            values = []
            last_block_num = high_watermark
            ids = set([])
            if len(d3) > 0:
                for tx in d3:
                    logger.info(f'extracting block number.. {tx["blockNumber"]} ')
                    last_block_num = tx["blockNumber"]
                    contract_abi = cont_name + "_abi"
                    checksum_address = to_checksum_address(cont_address)
                    mkr_contract = w3.eth.contract(checksum_address)

                    implementation_address = ""
                    if "proxy_contract" in cont_name:
                        cont_table = '`skale_contract_proxy`'
                        checksum_address = to_checksum_address(implementation)
                        mkr_contract = w3.eth.contract(checksum_address)
                        contract_abi = "escrow_abi"
                        logger.info(contract_abi)
                        mkr_contract.abi = allocator_abi[contract_abi]
                    if 'Allocator' in repo and contract_abi in allocator_abi:
                        mkr_contract.abi = allocator_abi[contract_abi]
                        logger.info(f'Allocator contract abi applied.')
                    else:
                        if contract_abi in manager_abi:
                            mkr_contract.abi = manager_abi[contract_abi]
                            logger.info(f'skale manager contract abi applied. ')
                        else:
                            if "proxy_factory" in contract_abi:
                                try:
                                    proxy_admin_address = allocator_abi["proxy_admin_address"]
                                    proxy_contract_address = to_checksum_address(tx["contractAddress"])
                                    contract_admin = w3.eth.contract(to_checksum_address(proxy_admin_address))
                                    contract_admin.abi = proxy_admin_abi["proxy_admin_abi"]
                                    function = contract_admin.get_function_by_name("getProxyImplementation")
                                    implementation_address = function(proxy_contract_address).call()
                                    logger.info(f'Checksum address: {checksum_address}'
                                                f', proxy_contract_address {proxy_contract_address}'
                                                f'Implementation address {implementation_address}')
                                    mkr_contract.abi = contract_admin.abi
                                except Exception as err:
                                    logger.error(f'Something went wrong reading proxy abi: {contract_abi},'
                                                 f'repo: {repo},'
                                                 f'error:{err}')

                    func_name = ""
                    json_dump_param = ""
                    params = {}

                    try:
                        func, params = mkr_contract.decode_function_input(tx['input'])
                        func_name = func.fn_name
                    except Exception as err:
                        logger.warning(f'No function found for this ABI input, for hash :{tx["hash"]} error: {err}')
                    try:
                        json_param = json.dumps(params)
                        if len(json_param) <= 1000:
                            json_dump_param = json.dumps(params)
                            if "delegation_controller" in cont_name and "delegationId" in json_dump_param:
                                parameter = json.loads(json_dump_param)
                                logger.info(f'Delegation state change happened , update needed for the delegation id:'
                                            f'{parameter["delegationId"]} ')
                                ids.add(parameter['delegationId'])

                    except Exception as err:
                        f' parameter is not serializable '

                    values.append(self.parameters(tx, contract_id, cont_address, func_name, json_dump_param
                                                  , implementation_address))

                if "delegation_controller" in cont_name and len(ids) > 0:
                    logger.info(f'ids to load {ids}')
                    update_delegations.execute(ids)
                if len(values) > 0:
                    self.upsert_values(values, last_block_num, contract_id, cont_table)
            else:
                logger.info(f'No new transactions to upsert on mysql.')

        except HTTPError as http_err:
            logger.error(f'Transaction execution failed because of a HTTP error. {http_err}')
            return False
        except Exception as err:
            logger.error(f'Transaction execution failed. {err}')
            return False

        logger.info(f'Completed loading contract name {cont_name} and address {cont_address} of {repo}')
        return True

    def get_response(self, api_call):
        response = requests.get(api_call)
        response.raise_for_status()
        jsonResponse = response.json()
        d2 = json.loads(json.dumps(jsonResponse))
        d3 = json.loads(json.dumps(d2["result"]))
        return d3

    def get_high_watermark(self, record):
        pass
