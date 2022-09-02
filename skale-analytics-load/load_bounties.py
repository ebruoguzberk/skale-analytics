from skale import Skale
from skale.utils.helper import init_default_logger
from config import ENDPOINT, ABI_FILEPATH
from utils import init_wallet
from web3 import Web3
import mysql_crud
from datetime import timezone
import datetime
import logging

logger = logging.getLogger(__name__)

from skale.utils.web3_utils import to_checksum_address

dt = datetime.datetime.now()
utc_time_year_month = str(dt.replace(tzinfo=timezone.utc).year) + '-' + str(dt.replace(tzinfo=timezone.utc).month)

init_default_logger()

wallet = init_wallet(ENDPOINT)
skale = Skale(ENDPOINT, ABI_FILEPATH, wallet)

logger.info(f'Starting bounty received bounty load.')

query = "SELECT DISTINCT d.validator_id, v.address validator_address, d.holder_address " \
        "FROM `mainnet`.`skale_delegations` d " \
        "LEFT OUTER JOIN `mainnet`.`skale_validators` v on v.id = d.validator_id " \
        "WHERE status in( 'UNDELEGATION_REQUESTED', 'DELEGATED', 'COMPLETED' )";

records = mysql_crud.fetch_all(query)

validators = []
values = []

for row in records:
    validator_id = row[0]
    validator_address = row[1]
    holder_address = row[2]

    # logger.info(f'loading bounty received, holder : {holder_address}')

    earned_bounties_data = skale.distributor.get_earned_bounty_amount(validator_id, holder_address)
    earned_bounties_amount = Web3.fromWei(earned_bounties_data['earned'], 'ether')

    values.append((holder_address, validator_id, earned_bounties_amount, "DELEGATOR"))

    if validator_address not in validators:
        # logger.info(f'loading bounty received, validator : {validator_address}')
        try:

            checksum_address = to_checksum_address(validator_address)
            earned_fee_data = skale.distributor.get_earned_fee_amount(checksum_address)
            earned_fee_amount = Web3.fromWei(earned_fee_data['earned'], 'ether')
            values.append((validator_address, validator_id, earned_fee_amount, "VALIDATOR"))
            logger.info(f'loading bounty unclaimed, validator : {validator_address}, {earned_fee_amount}')
            validators.append(validator_address)
        except Exception as http_err:
            logger.error("Validator may not exist: ", http_err)

query = \
        "INSERT INTO `mainnet`.`skale_bounty`(`address`,`validator_id`,`earned_bounty`,`type`) " \
        "VALUES(%s,%s,%s,%s) " \
        "ON DUPLICATE KEY UPDATE  `earned_bounty` = VALUES(`earned_bounty`)"
mysql_crud.execute_all(query, values)

logger.info("Loading bounties finished.")
