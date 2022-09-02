import pandas as pd
import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_node_health_check`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_node_health_check` '\
            '(`# Node ID`,' \
            '`Node name`,' \
            '`Is node active`,' \
            '`Node balance`,' \
            '`Validator SRW balance`,' \
            '`Component versions`,' \
            '`Container statuses`,' \
            '`SGX`,' \
            '`Endpoint`,' \
            '`Public IP`,' \
            '`Val nodes`,' \
            '`BTRFS`,' \
            '`Hardware`,' \
            '`Filebeat logs`,' \
            '`SSL`,' \
            '`SGX version`,' \
            '`Trusted endpoint`,' \
            '`Endpoint speed`)' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s", "%s",' \
            '"%s", "%s",  "%s",  "%s", "%s", "%s","%s","%s","%s","%s","%s")'
print(sql_query)

csv_data = pd.read_csv(f'{CSV_SOURCE}/node_health_check.csv')

for row in csv_data.iterrows():
    list = row[1].values
    print(list)
    mysql_crud.execute(sql_query% tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`node_health_check`' \
                   '(`# Node ID`,' \
                   '`Node name`,' \
                   '`Is node active`,' \
                   '`Validator SRW balance`,' \
                   '`Node balance`,' \
                   '`Container statuses`,' \
                   '`Component versions`,' \
                   '`SGX`,' \
                   '`SGX version`,' \
                   '`Endpoint`,' \
                   '`Hardware`,' \
                   '`Trusted endpoint`,' \
                   '`Filebeat logs`,' \
                   '`BTRFS`,' \
                   '`Val nodes`,' \
                   '`Public IP`)' \
                   'SELECT ' \
                   '`# Node ID`,' \
                   '   `Node name`,' \
                   '   `Is node active`,' \
                   '   `Validator SRW balance`,' \
                   '   `Node balance`,' \
                   '   `Container statuses`,' \
                   '   `Component versions`,' \
                   '   `SGX`,' \
                   '   `SGX version`,' \
                   '   `Endpoint`,' \
                   '   `Hardware`,' \
                   '   `Trusted endpoint`,' \
                   '   `Filebeat logs`,' \
                   '   `BTRFS`,' \
                   '   `Val nodes`,' \
                   '   `Public IP`' \
                   ' FROM load_node_health_check' \
                    ' ON DUPLICATE KEY UPDATE' \
                    '`# Node ID` =VALUES(`# Node ID`),' \
                   '`Node name` =VALUES(`Node name`),' \
                   '`Is node active` =VALUES(`Is node active`),' \
                   '`Validator SRW balance` =VALUES(`Validator SRW balance`),' \
                   '`Node balance` =VALUES(`Node balance`),' \
                   '`Container statuses` =VALUES(`Container statuses`),' \
                   '`Component versions` =VALUES(`Component versions`),' \
                   '`SGX` =VALUES(`SGX`),' \
                   '`SGX version` =VALUES(`SGX version`),' \
                   '`Endpoint` =VALUES(`Endpoint`),' \
                   '`Hardware` =VALUES(`Hardware`),' \
                   '`Trusted endpoint` =VALUES(`Trusted endpoint`),' \
                   '`Filebeat logs` =VALUES(`Filebeat logs`),' \
                   '`BTRFS` =VALUES(`BTRFS`),' \
                   '`Val nodes` =VALUES(`Val nodes`),' \
                   '`Public IP` =VALUES(`Public IP`)';

print(sql_query_insert);
mysql_crud.execute(sql_query_insert, None)
