import mysql_crud

load_query = "CALL `mainnet`.`Load_Proxy_Contracts_procedure`();" \

mysql_crud.execute(load_query, None)
