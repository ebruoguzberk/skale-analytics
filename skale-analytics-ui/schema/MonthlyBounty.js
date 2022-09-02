cube(`MonthlyBounty`, {
  sql: `SELECT *  FROM mainnet.monthly_expected_bounty_for_each_node_address`,
  
  joins: {
    
  },
  
  measures: {

    inflation_epoch_per_node: {
      sql: `inflation_epoch_per_node`,
      type: `max`
    },
  },

  dimensions: {
    this_epoch: {
      sql: `this_epoch`,
      type: `boolean`
    },
    prev_epoch: {
      sql: `prev_epoch`,
      type: `boolean`
    },
  },
  refreshKey: {
    every: `1 minute`
  }
});
