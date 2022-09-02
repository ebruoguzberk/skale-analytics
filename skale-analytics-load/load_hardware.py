import pandas as pd
import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_node_hardware`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_node_hardware` '\
            '(`# ID`,' \
            '`Name`,' \
            '`Cores`,' \
            '`Memory`,' \
            '`Storage`,' \
            '`Swap`)' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s")'

csv_data = pd.read_csv(f'{CSV_SOURCE}/hardware.csv')

for row in csv_data.iterrows():
    list = row[1].values
    mysql_crud.execute(sql_query% tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`node_hardware`' \
                   '(`# ID`,' \
                   '`Name`,' \
                   '`Cores`,' \
                   '`Memory`,' \
                   '`Storage`,' \
                   '`Swap`)' \
                   'SELECT * FROM load_node_hardware ' \
                   ' ON DUPLICATE KEY UPDATE ' \
                   '`# ID` = VALUES(`# ID`),' \
                   '`Name` = VALUES(`Name`),' \
                   '`Cores` = VALUES(`Cores`),' \
                   '`Memory` = VALUES(`Memory`),' \
                   '`Storage` = VALUES(`Storage`),' \
                   '`Swap` = VALUES(`Swap`)';

mysql_crud.execute(sql_query_insert, None)
