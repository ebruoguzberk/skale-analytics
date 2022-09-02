from datetime import datetime

import sys
from skale import Skale
from skale.utils.helper import init_default_logger
from config import ENDPOINT, ABI_FILEPATH

from utils import init_wallet
import mysql_crud

import logging

logger = logging.getLogger(__name__)

now = datetime.now()
init_default_logger()

wallet = init_wallet(ENDPOINT)
skale = Skale(ENDPOINT, ABI_FILEPATH, wallet)

max_delegation_num = 0

delegation_exist = True
logger.info("Loading all delegations from start.")

while delegation_exist:
    try:
        delegation = skale.delegation_controller.get_delegation_full(max_delegation_num)
    except Exception as err:
        delegation_exist = False
        logger.info("No more delegation to load")
    del_id = delegation['id']
    logger.info(f'Updating delegation status for id {del_id}')
    status = delegation['status']
    validator_id = delegation['validator_id']
    created = delegation['created']
    delegation_period = delegation['delegation_period']
    started = delegation['started']
    finished = delegation['finished']
    holder_address = delegation['address']
    info = delegation['info']
    amount = skale.web3.fromWei(delegation['amount'], 'ether')
    values=(del_id, validator_id, created, delegation_period, started, finished, holder_address,
                       info, status, amount)

    query = "INSERT INTO `mainnet`.`load_delegations`(`id`,`validator_id`,`created`" \
            ",`delegation_period`,`started`,`finished`,`holder_address`,`info`,`status`,`amount`) " \
            "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) " \
            "ON DUPLICATE KEY UPDATE `id` = VALUES(`id`)" \
            ",`validator_id` = VALUES(`validator_id`),`created` = VALUES(`created`)" \
            ",`delegation_period` = VALUES(`delegation_period`)" \
            ",`started` = VALUES(started),`finished` = VALUES(`finished`)" \
            ",`holder_address` = VALUES(`holder_address`)" \
            ",`info` = VALUES(`info`) ,`status` = VALUES(`status`),`amount` = VALUES(`amount`)"
    mysql_crud.execute(query, values)

    max_delegation_num = max_delegation_num + 1

query1 = "INSERT INTO `mainnet`.`skale_delegations`(`id`,`validator_id`,`created`" \
            ",`delegation_period`,`started`,`finished`,`holder_address`,`info`,`status`,`amount`) " \
            "SELECT `id`,`validator_id`,`created`" \
            ",`delegation_period`,`started`,`finished`,`holder_address`,`info`,`status`,`amount` " \
            "FROM `mainnet`.`load_delegations` " \
            "ON DUPLICATE KEY UPDATE `id` = VALUES(`id`)" \
            ",`validator_id` = VALUES(`validator_id`),`created` = VALUES(`created`)" \
            ",`delegation_period` = VALUES(`delegation_period`)" \
            ",`started` = VALUES(started),`finished` = VALUES(`finished`)" \
            ",`holder_address` = VALUES(`holder_address`)" \
            ",`info` = VALUES(`info`) ,`status` = VALUES(`status`),`amount` = VALUES(`amount`)"

mysql_crud.execute(query1, None)

logger.info("Loading all delegations from start finished.")

