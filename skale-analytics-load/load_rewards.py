import mysql_crud

load_query = "CALL `mainnet`.`Load_rewards_table`();" \

mysql_crud.execute(load_query, None)

load_query = "CALL `mainnet`.`Load_Token_stake_monthly`();"
mysql_crud.execute(load_query, None)

