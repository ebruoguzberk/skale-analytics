import mysql_crud
from TransactionMainCreator import MainCreator
from config import API_KEY

import logging

logger = logging.getLogger(__name__)


class TransactionInternalCreator(MainCreator):

    def parameters(self, tx, contract_id, cont_address, contract_function_name, contract_parameters,
                   implementation_address):
        tx_blockNumber = tx["blockNumber"]
        tx_timeStamp = tx["timeStamp"]
        tx_hash = tx["hash"]
        tx_from = tx["from"]
        tx_to = tx["to"]
        tx_value = tx["value"]
        tx_contractAddress = tx["contractAddress"]
        tx_gas = tx["gas"]
        tx_gasUsed = tx["gasUsed"]
        tx_isError = tx["isError"]
        tx_type = tx["type"]
        tx_traceId = tx["traceId"]
        tx_errCode = tx["errCode"]
        return (tx_blockNumber, tx_timeStamp, tx_hash, tx_from, tx_to
                , tx_value, tx_gas, tx_isError, '', tx_contractAddress
                , tx_gasUsed, tx_type, tx_traceId, tx_errCode, contract_id
                , cont_address, contract_function_name, contract_parameters, implementation_address)

    def upsert_values(self, values_to_insert, last_block_num, contract_id, contract_table):
        query = "INSERT INTO `mainnet`.`skale_contract_internal_transactions` (" \
                "`tx_blockNumber`,`tx_timeStamp`, `tx_hash`, `tx_from`,`tx_to`" \
                ", `tx_value`, `tx_gas`,`tx_isError`,`tx_input`,`tx_contractAddress`" \
                ",`tx_gasUsed`,`tx_type`,`tx_traceId`,`tx_errCode`,`contract_id`" \
                ",`contract_address`, `contract_function_name`,`contract_parameters`,`contract_implementation_address`)" \
                "VALUES(" \
                "%s,%s,%s,%s,%s" \
                ",%s,%s,%s,%s,%s" \
                ",%s,%s,%s,%s,%s" \
                ",%s,%s,%s,%s) " \
                "ON DUPLICATE KEY UPDATE " \
                "`tx_blockNumber` = VALUES(`tx_blockNumber`)" \
                ",`tx_timeStamp` =  VALUES(`tx_timeStamp`)" \
                ",`tx_hash` =  VALUES(`tx_hash`)" \
                ", `tx_from` =  VALUES(`tx_from`)" \
                ",`tx_to` =  VALUES(`tx_to`)" \
                ",`tx_value` = VALUES(`tx_value`) " \
                ",`tx_gas` =  VALUES(`tx_gas`)" \
                ",`tx_isError` = VALUES(`tx_isError`)" \
                ",`tx_input` =  VALUES(`tx_input`)" \
                ",`tx_contractAddress` = VALUES(`tx_contractAddress`)" \
                ",`tx_gasUsed` = VALUES( `tx_gasUsed`)" \
                ",`tx_type` =  VALUES(`tx_type`)" \
                ",`tx_traceId` =  VALUES(`tx_traceId`)" \
                ",`tx_errCode` =  VALUES(`tx_errCode`)" \
                ",`contract_id`= VALUES(`contract_id`)" \
                ",`contract_address`= VALUES(`contract_address`)" \
                ",`contract_function_name`= VALUES(`contract_function_name`)" \
                ", `contract_parameters`= VALUES(`contract_parameters`)" \
                ",`contract_implementation_address`= VALUES(`contract_implementation_address`);"
        logger.info(f"Executing insert into skale_contract_internal_transactions "
                    f"for {len(values_to_insert)} transactions")
        mysql_crud.execute_all(query, values_to_insert)
        logger.info(f"updating contract_table {contract_table} with last_internal_tx_block {last_block_num}  "
                    f"for contract_id: {contract_id}")
        query = f"UPDATE `mainnet`.{contract_table} " \
                "SET `last_internal_tx_block` = %s " \
                "WHERE `id` = %s;"
        block_values = (last_block_num, contract_id)

        mysql_crud.execute(query, block_values)

    def api_link(self, cont_address, high_watermark):
        return 'https://api.etherscan.io/api?module=account&action=txlistinternal' \
               '&address=' + cont_address + \
               '&startblock=' + str(high_watermark) + \
               '&endblock=99999999&sort=asc' \
               '&apikey' + API_KEY

    def get_high_watermark(self, record):
        return record[5]

    def proxy_contract_executable(self):
        return False
