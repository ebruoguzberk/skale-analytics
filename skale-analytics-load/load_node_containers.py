import pandas as pd
import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_node_containers`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_node_containers` '\
            '(`# Node ID`,' \
            '`Node name`,' \
            '`Admin`,' \
            '`API`,' \
            '`Nginx`,' \
            '`TM`,' \
            '`Watchdog`,' \
            '`Bounty`,' \
            '`Filebeat`,' \
            '`Configs`,' \
            '`CLI`,' \
            '`sChain`,' \
            '`IMA`,' \
            '`Lvmpy`)' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s",' \
            '"%s", "%s",  "%s",  "%s", "%s", "%s", "%s","%s")'

csv_data = pd.read_csv(f'{CSV_SOURCE}/node_containers.csv')

for row in csv_data.iterrows():
    list = row[1].values
    mysql_crud.execute(sql_query% tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`node_containers`' \
                   '(`# Node ID`,' \
                   '`Node name`,' \
                   '`Admin`,' \
                   '`API`,' \
                   '`Nginx`,' \
                   '`TM`,' \
                   '`Watchdog`,' \
                   '`Bounty`,' \
                   '`Filebeat`,' \
                   '`Configs`,' \
                   '`CLI`,' \
                   '`sChain`,' \
                   '`IMA`,' \
                   '`Lvmpy`)' \
                   'SELECT `# Node ID`,' \
                   '`Node name`,' \
                   '`Admin`,' \
                   '`API`,' \
                   '`Nginx`,' \
                   '`TM`,' \
                   '`Watchdog`,' \
                   '`Bounty`,' \
                   '`Filebeat`,' \
                   '`Configs`,' \
                   '`CLI`,' \
                   '`sChain`,' \
                   '`IMA`,' \
                   '`Lvmpy` FROM load_node_containers' \
                    ' ON DUPLICATE KEY UPDATE' \
                   '`# Node ID` = VALUES(`# Node ID`),' \
                   '`Node name` = VALUES(`Node name`),' \
                   '`Admin` = VALUES(`Admin`),' \
                   '`API` = VALUES(`API`),' \
                   '`Nginx` = VALUES(`Nginx`),' \
                   '`TM` = VALUES(`TM`),' \
                   '`Watchdog` = VALUES(`Watchdog`),' \
                   '`Bounty` = VALUES(`Bounty`),' \
                   '`Filebeat` = VALUES(`Filebeat`),' \
                   '`Configs` = VALUES(`Configs`),' \
                   '`CLI` = VALUES(`CLI`),' \
                   '`sChain` = VALUES(`sChain`),' \
                   '`IMA` = VALUES(`IMA`),' \
                   '`Lvmpy` = VALUES(`Lvmpy`)';
mysql_crud.execute(sql_query_insert, None)
