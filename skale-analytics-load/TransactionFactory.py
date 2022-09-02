from TransactionCreator import TransactionCreator
from TransactionInternalCreator import TransactionInternalCreator
from TransactionTokenCreator import TransactionTokenCreator


class TransactionFactory:
    def get_transaction_ops(self, type):
        if type == 'Transaction':
            return TransactionCreator()
        elif type == 'InternalTransaction':
            return TransactionInternalCreator()
        elif type == 'TokenTransactions':
            return TransactionTokenCreator()
        else:
            raise ValueError(format)
