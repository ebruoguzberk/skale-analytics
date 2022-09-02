import pandas as pd
import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_schain_health_checks`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_schain_health_checks`'\
            '(`# Node ID`,' \
            ' `Schain Name`,' \
            ' `HTTP`,' \
            ' `HTTPs`,' \
            ' `Blocks`,' \
            ' `Data directory`,' \
            ' `DKG`,' \
            ' `Config file`,' \
            ' `Volume`,' \
            ' `Container`,' \
            ' `IMA`,' \
            ' `Firewall`,' \
            ' `RPC`)  ' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s", "%s",' \
            '"%s", "%s",  "%s",  "%s", "%s", "%s")'


csv_data = pd.read_csv(f'{CSV_SOURCE}/schain_health_checks.csv')

for row in csv_data.iterrows():
    list = row[1].values
    mysql_crud.execute(sql_query % tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`schain_health_checks`' \
                   '(`# Node ID`,' \
                   ' `Schain Name`,' \
                   ' `HTTP`,' \
                   ' `HTTPs`,' \
                   ' `Blocks`,' \
                   ' `Data directory`,' \
                   ' `DKG`,' \
                   ' `Config file`,' \
                   ' `Volume`,' \
                   ' `Container`,' \
                   ' `IMA`,' \
                   ' `Firewall`,' \
                   ' `RPC`)  ' \
                   'SELECT * FROM load_schain_health_checks' \
                   ' ON DUPLICATE KEY UPDATE' \
                   '`# Node ID` = VALUES(`# Node ID`),' \
                   '`Schain Name` = VALUES(`Schain Name`),' \
                   '`HTTP` = VALUES(`HTTP`),' \
                   '`HTTPs` = VALUES(`HTTPs`),' \
                   '`Blocks` = VALUES(`Blocks`),' \
                   '`Data directory` = VALUES(`Data directory`),' \
                   '`DKG` = VALUES(`DKG`),' \
                   '`Config file` = VALUES(`Config file`),' \
                   '`Volume` = VALUES(`Volume`),' \
                   '`Container` = VALUES(`Container`),' \
                   '`IMA` = VALUES(`IMA`),' \
                   '`Firewall` = VALUES(`Firewall`),' \
                   '`RPC` = VALUES(`RPC`)';

print(sql_query_insert);
mysql_crud.execute(sql_query_insert, None)
