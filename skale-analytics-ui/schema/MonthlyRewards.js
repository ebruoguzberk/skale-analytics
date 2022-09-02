cube(`MonthlyRewards`, {
  sql: `SELECT * FROM mainnet.monthly_rewards`,
  
  joins: {
    
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: []
    },
    full_reward: {
      sql: `full_reward`,
      type: `sum`
    },
    validator_reward: {
      sql: `validator_reward`,
      type: `sum`
    }
  },
  
  dimensions: {
    nodeAddress: {
      sql: `node_address`,
      type: `string`
    },

    validator_id: {
      sql: `validator_id`,
      type: `string`
    },
    
    year_month: {
      sql: `yyyymm`,
      type: `string`
    }
  }, refreshKey: {
    every: `1 minute`
  }
});
