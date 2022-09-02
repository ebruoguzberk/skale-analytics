import mysql_crud
from TransactionMainCreator import MainCreator
import logging
from config import API_KEY

logger = logging.getLogger(__name__)

class TransactionTokenCreator(MainCreator):

    def parameters(self, tx, contract_id, cont_address,
                   contract_function_name, contract_parameters,
                   implementation_address):
        tx_blockNumber = tx["blockNumber"]
        tx_timeStamp = tx["timeStamp"]
        tx_hash = tx["hash"]
        tx_nonce = tx["nonce"]
        tx_blockHash = tx["blockHash"]
        tx_from = tx["from"]
        tx_contractAddress = tx["contractAddress"]
        tx_to = tx["to"]
        tx_value = tx["value"]
        tx_gas = tx["gas"]
        tx_gasPrice = tx["gasPrice"]
        tx_gasUsed = tx["gasUsed"]
        tx_cumulativeGasUsed = tx["cumulativeGasUsed"]
        tx_tokenName = tx["tokenName"]
        tx_tokenSymbol = tx["tokenSymbol"]
        tx_tokenDecimal = tx["tokenDecimal"]
        tx_transactionIndex = tx["transactionIndex"]

        tx_confirmations = tx["confirmations"]

        return (tx_blockNumber, tx_timeStamp, tx_hash, tx_nonce, tx_transactionIndex
                , tx_from, tx_to, tx_value, tx_gas, tx_gasPrice
                , '', '', '', tx_contractAddress, tx_cumulativeGasUsed
                , tx_gasUsed, tx_confirmations, contract_id, cont_address, contract_function_name
                , contract_parameters, implementation_address, tx_tokenName, tx_tokenSymbol, tx_tokenDecimal
                , tx_blockHash)

    def upsert_values(self, values_to_insert, last_block_num, contract_id, contract_table):
        query = "INSERT INTO `mainnet`.`skale_contract_token_transactions`" \
                "(`tx_blockNumber`,`tx_timeStamp`,`tx_hash`,`tx_nonce`,`tx_transactionIndex`" \
                ",`tx_from`,`tx_to`,`tx_value`,`tx_gas`,`tx_gasPrice`" \
                ",`tx_isError`,`tx_txreceipt_status`,`tx_input`,`tx_contractAddress`,`tx_cumulativeGasUsed`" \
                ",`tx_gasUsed`,`tx_confirmations`,contract_id,contract_address,contract_function_name" \
                ", contract_parameters, contract_implementation_address, tx_tokenName, tx_tokenSymbol,tx_tokenDecimal" \
                ", tx_blockHash)" \
                "VALUES(" \
                "%s,%s,%s,%s,%s," \
                "%s,%s,%s,%s,%s," \
                "%s,%s,%s,%s,%s," \
                "%s,%s,%s,%s,%s," \
                "%s,%s,%s,%s,%s," \
                "%s) " \
                "ON DUPLICATE KEY UPDATE " \
                "`tx_blockNumber` = VALUES(`tx_blockNumber`)" \
                ",`tx_timeStamp` = VALUES( `tx_timeStamp`)" \
                ",`tx_hash` = VALUES( `tx_hash`) " \
                ", `tx_nonce` = VALUES( `tx_nonce`)" \
                ",`tx_transactionIndex` = VALUES( `tx_transactionIndex`)" \
                ",`tx_from` = VALUES( `tx_from`)" \
                ",`tx_to` = VALUES( `tx_to`)" \
                ",`tx_value` = VALUES( `tx_value`) " \
                ",`tx_gas` = VALUES( `tx_gas`)" \
                ",`tx_gasPrice` = VALUES( `tx_gasPrice`)" \
                ",`tx_isError` = VALUES( `tx_isError`)" \
                ",`tx_txreceipt_status` = VALUES( `tx_txreceipt_status`) " \
                ",`tx_input` = VALUES( `tx_input`)" \
                ",`tx_contractAddress` = VALUES(`tx_contractAddress`)" \
                ",`tx_cumulativeGasUsed` = VALUES(`tx_cumulativeGasUsed`)" \
                ",`tx_gasUsed` = VALUES( `tx_gasUsed`)" \
                ",`tx_confirmations` = VALUES( `tx_confirmations`)" \
                ",`contract_id`= VALUES(`contract_id`)" \
                ",`contract_address`= VALUES(`contract_address`)" \
                ",`contract_function_name`= VALUES(`contract_function_name`)" \
                ",`contract_parameters`= VALUES(`contract_parameters`)" \
                ",`contract_implementation_address` = VALUES(`contract_implementation_address`)" \
                ",`tx_tokenName`= VALUES(`tx_tokenName`)" \
                ",`tx_tokenSymbol`= VALUES(`tx_tokenSymbol`)" \
                ",`tx_tokenDecimal`= VALUES(`tx_tokenDecimal`)" \
                ",`tx_blockHash` = VALUES(`tx_blockHash`);"

        logger.info(f"Executing insert into skale_contract_transactions "
                    f"for {len(values_to_insert)} transactions")
        mysql_crud.execute_all(query, values_to_insert)
        logger.info(f"Updating contract_table { contract_table} with lastblock {last_block_num} "
                    f"for contract_id: {contract_id}")

        query = f"UPDATE `mainnet`.{contract_table} " \
                "SET `lastblock` = %s " \
                "WHERE `id` = %s;"
        block_values = (last_block_num, contract_id)

        mysql_crud.execute(query, block_values)

    def api_link(self, cont_address, high_watermark):
        return 'https://api.etherscan.io/api?module=account' \
               '&action=tokentx' \
               '&contractaddress=' + cont_address + '' \
                                                    '&startblock=' + str(high_watermark) + \
               '&endblock=99999999&sort=asc' \
               '&apikey' + API_KEY

    def get_high_watermark(self, record):
        return record[2]

    def proxy_contract_executable(self):
        return True
