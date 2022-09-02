cube(`NetworkStats`, {
  sql: `SELECT *,floor(Total_Amount_Current_Delegations) as total_staked,
  current_date as createdAt
  FROM mainnet.network_stats`,
  
  joins: {
    
  },

  measures: {
    
    total_staked: {
      sql: `total_staked`,
      type: `max`
    },

    CurrentDelegationCount: {
      sql: `CurrentDelegationCount`,
      type: `max`
    },
    ActiveNodes: {
      sql: `active_nodes_in_network`,
      type: `max`
    },

    validator_count: {
      sql: `validator_count`,
      type: `max`
    },

    current_unique_delegators: {
      sql: `current_unique_delegators`,
      type: `max`
    },

  },
  dimensions: {
    
  },
  refreshKey: {
    every: `1 minute`
  }
});
