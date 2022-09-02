from datetime import datetime
from skale import Skale
from skale.utils.helper import init_default_logger
from config import ENDPOINT, ABI_FILEPATH
import mysql_crud
from web3 import Web3
from utils import init_wallet
import logging

logger = logging.getLogger(__name__)

now = datetime.now()
init_default_logger()

wallet = init_wallet(ENDPOINT)
skale = Skale(ENDPOINT, ABI_FILEPATH, wallet)

w3 = Web3(Web3.HTTPProvider(ENDPOINT))

logger.info(f'Loading all validators started')

validators = skale.validator_service.ls()
validator_values = []
linked_nodes = []

for validator in validators:
    vid = int(validator['id'])
    logger.info(f'Loading validator id {vid}')
    address = str(validator['validator_address'])
    name = validator['name']
    fee = validator['fee_rate']
    mdr = skale.web3.fromWei(validator['minimum_delegation_amount'], 'ether')
    trusted = validator['trusted']
    balance = w3.fromWei(w3.eth.getBalance(w3.toChecksumAddress(address)),"ether")
    start_date = datetime(2020, 1, 1)
    num_months = (now.year - start_date.year) * 12 + (now.month - start_date.month)

    current_staked = w3.fromWei(skale.delegation_controller.getDelegatedToValidator(vid, num_months), 'ether')
    nextmonth_staked = w3.fromWei(skale.delegation_controller.getDelegatedToValidator(vid, num_months+1), 'ether')
    logger.info(f"{name} - current_staked : {current_staked}, nextmonth_staked: {nextmonth_staked}");
    skale.delegation_controller. getDelegatedToValidator(vid,num_months)

    validator_values.append((vid, name, address, trusted, mdr, fee, balance,current_staked,nextmonth_staked))
    res = skale.validator_service.get_linked_addresses_by_validator_id(vid)
    for link in res:
        balance_node = w3.fromWei(w3.eth.getBalance(w3.toChecksumAddress(link)), "ether")
        linked_nodes.append((vid, link, balance_node))

### Load Validators

sql_truncate_query = "TRUNCATE table `mainnet`.`load_validators`"
mysql_crud.execute(sql_truncate_query, None)

query = "INSERT INTO `mainnet`.`load_validators`(`id`,`name`,`address`,`trusted`,`mdr`,`fee_rate`,`balance`,`total_staked`,`total_staked_next_epoch`) " \
        "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s);"

mysql_crud.execute_all(query, validator_values)

sql_update_query = "INSERT INTO mainnet.skale_validators (`id`,`name`,`address`,`trusted`" \
                   ",`mdr`,`fee_rate`,`balance`,`total_staked`,`total_staked_next_epoch`) " \
                   "SELECT sl.`id`,sl.`name`,sl.`address`,sl.`trusted`" \
                   ",sl.`mdr`,sl.`fee_rate`,sl.`balance`,sl.`total_staked`,sl.`total_staked_next_epoch` " \
                   "FROM  mainnet.load_validators sl " \
                   "ON DUPLICATE KEY UPDATE " \
                   "`id`= VALUES(`id`),`name`= VALUES(`name`),`address`= VALUES(`address`)," \
                   "`trusted`= VALUES(`trusted`),`mdr`= VALUES(`mdr`),`fee_rate`= VALUES(`fee_rate`)," \
                   "`balance` = VALUES(`balance`),`total_staked`= VALUES(`total_staked`)," \
                   "`total_staked_next_epoch`= VALUES(`total_staked_next_epoch`);"

mysql_crud.execute(sql_update_query, None)

###Load Linked addresses

sql_truncate_query = "TRUNCATE table `mainnet`.`load_linked_nodes`"
mysql_crud.execute(sql_truncate_query, None)

load_query = "INSERT INTO `mainnet`.`load_linked_nodes`(`validator_id`,`address`, `balance`) " \
             "VALUES(%s,%s,%s);"
mysql_crud.execute_all(load_query, linked_nodes)

sql_update_query = "INSERT INTO mainnet.skale_linked_nodes (validator_id,address,active, balance)  " \
                   "SELECT sl.validator_id,sl.address,true,sl.balance  " \
                   "FROM  mainnet.load_linked_nodes sl " \
                   "union      " \
                   "SELECT sln.validator_id, sln.address, false, sl.balance  " \
                   "FROM  mainnet.load_linked_nodes sl  " \
                   "right outer join mainnet.skale_linked_nodes sln   " \
                   "on sln.validator_id = sl.validator_id  and sln.address = sl.address     " \
                   "where sl.validator_id is null " \
                   "ON DUPLICATE KEY UPDATE active = VALUES(`active`), balance = VALUES(`balance`);"
mysql_crud.execute(sql_update_query, None)

logger.info(f'Loading all validators finished')
