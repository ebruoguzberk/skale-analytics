from datetime import datetime
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


def execute(delegations):
    logger.info(f'Updating delegations from transaction calls. {len(delegations)}')

    values = []
    for del_id in delegations:
        logger.info(f'Updating delegation id: {del_id}')
        delegation = skale.delegation_controller.get_delegation_full(del_id)
        status = delegation['status']
        validator_id = delegation['validator_id']
        created = delegation['created']
        delegation_period = delegation['delegation_period']
        started = delegation['started']
        finished = delegation['finished']
        holder_address = delegation['address']
        info = delegation['info']
        amount = skale.web3.fromWei(delegation['amount'], 'ether')

        values.append((del_id, validator_id, created, delegation_period, started, finished, holder_address, info,
                       status, amount))

    query = "INSERT INTO `mainnet`.`skale_delegations`(`id`,`validator_id`,`created`" \
            ",`delegation_period`,`started`,`finished`,`holder_address`,`info`,`status`,`amount`) " \
            "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) " \
            "ON DUPLICATE KEY UPDATE " \
            "`validator_id` = VALUES(validator_id),`created` = VALUES(created)" \
            ",`delegation_period` = VALUES(delegation_period)," \
            "`started` = VALUES(started),`finished` = VALUES(finished),`holder_address` = VALUES(holder_address)" \
            ",`info` = VALUES(info) ,`status` = VALUES(status),`amount` = VALUES(amount)"

    mysql_crud.execute_all(query, values)

    logger.info(f'Updating delegations from transactions finished.')
