from TransactionFactory import TransactionFactory
from contracts import get_contracts, get_token_contract, get_proxy_contracts,get_internal_contracts

import logging

logger = logging.getLogger(__name__)

factory = TransactionFactory()

for record in get_contracts():
    factory.get_transaction_ops("Transaction").transaction_load(record)

for record in get_internal_contracts():
    factory.get_transaction_ops("InternalTransaction").transaction_load(record)

for record in get_token_contract():
    factory.get_transaction_ops("TokenTransactions").transaction_load(record)
