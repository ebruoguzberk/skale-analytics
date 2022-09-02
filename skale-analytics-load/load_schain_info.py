import pandas as pd

import mysql_crud
from config import CSV_SOURCE

sql_truncate_query = "TRUNCATE table `mainnet`.`load_schain_info`"
mysql_crud.execute(sql_truncate_query, None)

sql_query = 'INSERT INTO `mainnet`.`load_schain_info`' \
            '(`# Name`,' \
            '`Type`,' \
            '`Creation time`,' \
            '`Owner`,' \
            '`Chain ID`,' \
            '`Rotation ID`,' \
            '`Nodes`)' \
            'VALUES ("%s", "%s",  "%s",  "%s", "%s", "%s", "%s")'


file = open(f'{CSV_SOURCE}/schain_info.csv','r')
contents = file.read()
if '"[' not in contents:
    replaced_contents = contents.replace('[', '"[').replace(']',']"')
    file.close()
    file = open(f'{CSV_SOURCE}/schain_info.csv','w')
    file.write(replaced_contents)

file.close()


csv_data = pd.read_csv(f'{CSV_SOURCE}/schain_info.csv')

for row in csv_data.iterrows():
    list = row[1].values

    mysql_crud.execute(sql_query % tuple(list), None)

sql_query_insert = 'INSERT INTO `mainnet`.`schain_info`' \
                   '(`# Name`,' \
                   '`Type`,' \
                   '`Creation time`,' \
                   '`Owner`,' \
                   '`Chain ID`,' \
                   '`Rotation ID`,' \
                   '`Nodes`,' \
                   '`Live`) ' \
                   'select * from(' \
                   'SELECT `load_schain_info`.`# Name`, ' \
                   '`load_schain_info`.`Type`,' \
                   '`load_schain_info`.`Creation time`,' \
                   '`load_schain_info`.`Owner`,' \
                   '`load_schain_info`.`Chain ID`,' \
                   '`load_schain_info`.`Rotation ID`,' \
                   '`load_schain_info`.`Nodes`,' \
                   '1 as Live ' \
                   'FROM `mainnet`.`load_schain_info` ' \
                   'UNION ALL ' \
                   'SELECT `schain_info`.`# Name`,' \
                   '`schain_info`.`Type`,' \
                   '`schain_info`.`Creation time`,' \
                   '`schain_info`.`Owner`,' \
                   '`schain_info`.`Chain ID`,' \
                   '`schain_info`.`Rotation ID`,' \
                   '`schain_info`.`Nodes`, ' \
                   '0 as Live ' \
                   'FROM `mainnet`.`schain_info` ' \
                   'left outer join `mainnet`.`load_schain_info` lsi on lsi.`# Name` =  `mainnet`.`schain_info`.`# Name` ' \
                   'where  lsi.`# Name` is null ' \
                   ')as x' \
                   ' ON DUPLICATE KEY UPDATE' \
                   '`# Name` = VALUES(`# Name`),' \
                   '`Type` = VALUES(`Type`),' \
                   '`Creation time` = VALUES(`Creation time`),' \
                   '`Owner` = VALUES(`Owner`),' \
                   '`Chain ID` = VALUES(`Chain ID`),' \
                   '`Rotation ID` = VALUES(`Rotation ID`),' \
                   '`Nodes` = VALUES(`Nodes`),' \
                   '`Live` = VALUES(`Live`)';

mysql_crud.execute(sql_query_insert, None)
