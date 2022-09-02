from datetime import datetime
from skale.utils.helper import ip_from_bytes, init_default_logger
import mysql_crud
from skale.utils.web3_utils import public_key_to_address
from skale import Skale
from config import ENDPOINT, ABI_FILEPATH
from utils import init_wallet
from web3 import Web3

import logging

logger = logging.getLogger(__name__)

now = datetime.now()
init_default_logger()

w3 = Web3(Web3.HTTPProvider(ENDPOINT))

wallet = init_wallet(ENDPOINT)
skale = Skale(ENDPOINT, ABI_FILEPATH, wallet)

nodes_number = skale.nodes.get_nodes_number()

nodes = list(range(nodes_number))

logger.info(f'Started Loading Nodes from start')

values = []
for node_id in nodes:
    try:
        data = skale.nodes.get(node_id)
    except Exception:
        logger.info(f'error happened with ', node_id)
    logger.info(f'Updating node status for nodeid {node_id}')
    validator_id = data.get('validator_id')
    name = data.get('name')
    ip = ip_from_bytes(data.get('ip'))
    pub_key = data['publicKey']
    address = public_key_to_address(pub_key)
    port = data.get('port')
    status = data.get('status')
    balance = w3.fromWei(w3.eth.getBalance(w3.toChecksumAddress(address)), "ether");
    values.append((node_id, validator_id, name, ip, pub_key, address, port, status, balance))

sql_truncate_query = "TRUNCATE table `mainnet`.`load_nodes`"
mysql_crud.execute(sql_truncate_query, None)

load_query = "INSERT INTO `mainnet`.`load_nodes`(`id`,`validator_id`,`name`,`ip`" \
             ",`pub_key`,`address`,`port`,`status`, `balance`) " \
             "VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)" \
             "ON DUPLICATE KEY UPDATE " \
             "`id`=VALUES (`id`)" \
             ",`validator_id`=VALUES (`validator_id`)" \
             ",`name`=values(`name`),`ip`=values (`ip`)," \
             "`pub_key`= values(`pub_key`),`address`=VALUES(`address`),`port`=values(`port`)" \
             ",`status`=values(`status`), `balance` = VALUES(`balance`)"
mysql_crud.execute_all(load_query, values)

sql_update_query = "INSERT INTO mainnet.skale_nodes (`id`,`validator_id`,`name`,`ip`" \
                   ",`pub_key`,`address`,`port`,`status`, `balance`)  " \
                   "SELECT `id`,`validator_id`,`name`,`ip`" \
                   ",`pub_key`,`address`,`port`,status,sl.balance  " \
                   "FROM  mainnet.load_nodes sl " \
                   "ON DUPLICATE KEY UPDATE `id`=VALUES (`id`)" \
                   ",`validator_id`=VALUES (`validator_id`)" \
                   ",`name`=values(`name`),`ip`=values (`ip`)," \
                   "`pub_key`= values(`pub_key`),`address`=VALUES(`address`),`port`=values(`port`)" \
                   ",`status`=values(`status`), `balance` = VALUES(`balance`)"
                   # "union      " \
                   # "SELECT sln.`id`,sln.`validator_id`,sln.`name`,sln.`ip`" \
                   # ",sln.`pub_key`,sln.`address`,sln.`port`, 2, sl.balance  " \
                   # "FROM  mainnet.load_nodes sl  " \
                   # "right outer join mainnet.skale_nodes sln   " \
                   # "on sln.address = sl.address  " \
                   # "where sl.validator_id is null " \


mysql_crud.execute(sql_update_query, None)

logger.info(f'Node loading finished')
