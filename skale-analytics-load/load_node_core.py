import pandas as pd

import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_nodes_info`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_nodes_info` (`# ID`, `Name`, `IP`, `Status`, ' \
            '`Address`,  `Balance (Wei)`,`Validator ID`,`Validator Name`, `Base containers`,`SGX`)  ' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s", "%s", "%s", "%s", "%s")'


csv_data = pd.read_csv(f'{CSV_SOURCE}/nodes_info.csv')

for row in csv_data.iterrows():
    list = row[1].values
    mysql_crud.execute(sql_query % tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`nodes_info`' \
                   '(`# ID`,' \
                   '`Name`,' \
                   '`IP` ,' \
                   '`Status`,' \
                   '`Address`,' \
                   '`Balance (Wei)`,' \
                   '`Base containers`,' \
                   '`SGX`)' \
                   'SELECT `# ID`,' \
                   '`Name`,' \
                   '`IP` ,' \
                   '`Status`,' \
                   '`Address`,' \
                   '`Balance (Wei)`,' \
                   '`Base containers`,' \
                   '`SGX` FROM load_nodes_info' \
                   ' ON DUPLICATE KEY UPDATE' \
                   '`# ID` = VALUES(`# ID`),' \
                   '`Name` = VALUES(`Name`),' \
                   '`IP` = VALUES(`IP`),' \
                   '`Status` = VALUES(`Status`),' \
                   '`Address` = VALUES(`Address`),' \
                   '`Balance (Wei)` = VALUES(`Balance (Wei)`),' \
                   '`Base containers` = VALUES(`Base containers`),' \
                   '`SGX` = VALUES(`SGX`)';
mysql_crud.execute(sql_query_insert, None)
