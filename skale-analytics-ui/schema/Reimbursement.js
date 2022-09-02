cube(`Reimbursement`, {
  sql: `SELECT tx_hash, name as validatorName, NodeOperator, 
tx_from, contract, contract_function_name, 
ethcost, tx_datetime,tx_timeStamp, tx_isError, contract_parameters
FROM mainnet.gas_reimbursement`,
  
  joins: {
    
  },
  
  measures: {
    operatorCount: {
      sql: `NodeOperator`,
      type: "countDistinct"
    },
    count: {
      type: `count`,
      drillMembers: [tx_hash, tx_timeStamp]
    },
    ethTotal: {
      sql: `ethCost`,
      type: `sum`
    },
  },

  dimensions: {
    validatorName: {
      sql: `validatorName`,
      type: `string`
    },
    NodeOperator: {
      sql: `NodeOperator`,
      type: `string`
    },
    tx_from: {
      sql: `tx_from`,
      type: `string`
    },
    contract: {
      sql: `contract`,
      type: `string`
    },
    contract_parameters: {
      sql: `contract_parameters`,
      type: `string`
    },
    contract_function_name: {
      sql: `contract_function_name`,
      type: `string`
    },
    tx_timeStamp: {
      sql: `tx_timeStamp`,
      type: `time`
    },
    tx_isError: {
      sql: `tx_isError`,
      type: `time`
    },
    tx_datetime: {
      sql: `tx_datetime`,
      type: `time`
    },
    tx_hash: {
      sql: `tx_hash`,
      type: `string`
    },
    ethCost: {
      sql: `ethCost`,
      type: `number`
    }
  },
  refreshKey: {
    every: `1 minute`
  },
});
