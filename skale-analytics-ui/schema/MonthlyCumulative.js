cube(`MonthlyCumulative`, {
  sql: `SELECT * FROM mainnet.monthly_cumulative`,

  joins: {
  },

  measures: {
    count: {
      type: `count`,
      drillMembers: []
    },
    Amount: {
      sql: `amt`,
      type: `runningTotal`
    }
  },
  
  dimensions: {
    holder_address:{
      sql: `holder`,
      type: `string`,
      primaryKey: true,
      shown: true
    },
    validator_id: {
      sql: `validator_id`,
      type: `string`,
      primaryKey: true,
      shown: true
    },
    created: {
      sql: `created`,
      type: `time`,
      primaryKey: true,
      shown: true
    }

    },
  refreshKey: {
    every: `1 minute`
  }

});
