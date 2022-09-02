import mysql_crud

import logging

logger = logging.getLogger(__name__)

def get_contracts():
    sql_query = "SELECT `skale_contract`.`id`," \
                "`skale_contract`.`address`," \
                "COALESCE(`skale_contract`.`lastblock` ,0)  as high_watemark ," \
                "`skale_contract`.`name` ," \
                "`skale_contract`.`repository`, " \
                "COALESCE(`skale_contract`.`last_internal_tx_block` ,0)  as high_watemark_internal " \
                "FROM `mainnet`.`skale_contract` " \
                "WHERE `skale_contract`.`address` is not null " \
                "and name <> 'proxy_contract'" \
                "and name <> 'skale_token';"

    records = mysql_crud.fetch_all(sql_query)
    if len(records) > 0:
        print(str(len(records)) + ' contracts found')
        return records
    else:
        logger.error("No contracts found")


def get_internal_contracts():
    sql_query = "SELECT `skale_contract`.`id`," \
                "`skale_contract`.`address`," \
                "COALESCE(`skale_contract`.`lastblock` ,0)  as high_watemark ," \
                "`skale_contract`.`name` ," \
                "`skale_contract`.`repository`, " \
                "COALESCE(`skale_contract`.`last_internal_tx_block` ,0)  as high_watemark_internal " \
                "FROM `mainnet`.`skale_contract` " \
                "WHERE `skale_contract`.`address` is not null " \
                "and name = 'proxy_factory';"

    records = mysql_crud.fetch_all(sql_query)
    if len(records) > 0:
        print(str(len(records)) + ' contracts found')
        return records
    else:
        logger.error("No contracts found")


def get_proxy_contracts():
    sql_query = "SELECT `skale_contract`.`id`," \
                "`skale_contract`.`address`," \
                "COALESCE(`skale_contract`.`lastblock` ,0)  as high_watemark ," \
                "`skale_contract`.`name` ," \
                "`skale_contract`.`repository`, " \
                "COALESCE(`skale_contract`.`last_internal_tx_block` ,0)  as high_watemark_internal, " \
                "`implementation_address` implementation ," \
                "holder_address " \
                "FROM `mainnet`.`skale_contract_proxy` as skale_contract " \
                "WHERE `skale_contract`.`address` is not null ;"

    records = mysql_crud.fetch_all(sql_query)
    if records and len(records) > 0:
        print(str(len(records)) + ' proxy contracts found')
        return records
    else:
        logger.error("No contracts found")


def get_token_contract():
    sql_query = "SELECT `skale_contract`.`id`," \
                "`skale_contract`.`address`," \
                "COALESCE(`skale_contract`.`lastblock` ,0)  as high_watemark ," \
                "`skale_contract`.`name` ," \
                "`skale_contract`.`repository`, " \
                "COALESCE(`skale_contract`.`last_internal_tx_block` ,0)  as high_watemark_internal " \
                "FROM `mainnet`.`skale_contract` " \
                "WHERE `skale_contract`.`address` is not null " \
                "and name = 'skale_token';"

    records = mysql_crud.fetch_all(sql_query)
    if len(records) > 0:
        print(str(len(records)) + ' contracts found')
        return records
    else:
        logger.error("No contracts found")
