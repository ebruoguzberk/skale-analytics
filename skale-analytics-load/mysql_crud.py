import mysql.connector
from mysql.connector import Error

import logging

logger = logging.getLogger(__name__)

def execute(query, values):
    """ Connect to MySQL database """
    my_db = None
    try:
        my_db = mysql.connector.connect(option_files='config.cnf', option_groups=['mysql'])
        if my_db.is_connected():
            cursor = my_db.cursor()
            if values is not None:
                cursor.execute(query, values)
            else:
                cursor.execute(query)
            my_db.commit()
            # print(cursor.rowcount, "records changed in Mysql Database")
    except Error as e:
        logger.error("Execute query on Mysql failed:", e)

    finally:
        if my_db is not None and my_db.is_connected():
            my_db.close()


def execute_all(query, values):
    """ Connect to MySQL database """
    my_db = None
    try:
        my_db = mysql.connector.connect(option_files='config.cnf', option_groups=['mysql'])
        if my_db.is_connected():

            cursor = my_db.cursor()
            cursor.executemany(query, values)
            my_db.commit()
            # print(cursor.rowcount, "records changed in Mysql Database")

    except Error as e:
        logger.error("Mysql Error occured during execute all", e)

    finally:
        if my_db is not None and my_db.is_connected():
            my_db.close()


def fetch_all(query):
    my_db = None
    try:
        my_db = mysql.connector.connect(option_files='config.cnf', option_groups=['mysql'])

        if my_db.is_connected():
            cursor = my_db.cursor()
            cursor.execute(query)
            return cursor.fetchall()

    except Error as e:
        logger.error("Fetch All from Mysql failed:", e)

    finally:
        if my_db is not None and my_db.is_connected():
            my_db.close()
