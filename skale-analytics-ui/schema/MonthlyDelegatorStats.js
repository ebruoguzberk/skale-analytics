cube(`MonthlyDelegatorStats`, {
  sql: `SELECT \`skale_delegator_monthly\`.\`holder_address\`,
    \`skale_delegator_monthly\`.\`validator_id\`,
    \`skale_delegator_monthly\`.\`YYYYMM\`,
    concat(\`skale_delegator_monthly\`.\`YYYYMM\`,'01') yyyyMMdd,
    \`skale_delegator_monthly\`.\`MonthName\`,
    \`skale_delegator_monthly\`.\`epoch\`,
    \`skale_delegator_monthly\`.\`TotalStaked\`,
    cast(TotalDelegatorRewards *  \`skale_delegator_monthly\`.\`TotalStaked\`/vm.TotalStaked as decimal(16,2)) as TokenHolder_Reward,
    CASE WHEN em.address IS NOT NULL and em.holder_address IS NOT NULL 
\tTHEN em.holder_address else skale_delegator_monthly.holder_address end holder, 
    concat("Escrow: ", em.address) as escrow_address
FROM mainnet.skale_delegator_monthly 
left join mainnet.skale_validator_monthly vm on vm.validator_id = skale_delegator_monthly.validator_id
and vm.YYYYMM = skale_delegator_monthly.YYYYMM 
LEFT OUTER JOIN mainnet.skale_contract_proxy em on em.address = skale_delegator_monthly.holder_address
where coalesce (TotalDelegatorRewards,0) > 0`,

  joins: {  Validator: {
      relationship: `belongsTo`,
      sql: `${MonthlyDelegatorStats}.validator_id = ${Validator}.id`
    }
  },

  measures: {
    count: {
      type: `count`,
      drillMembers: []
    },
    
    amount: {
      sql: `TotalStaked`,
      type: `sum`
    },
    TokenHolder_Reward: {
      sql: `TokenHolder_Reward`,
      type: `sum`
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
    epoch:{
      sql: `epoch`,
      type: `number`,
      primaryKey: true,
      shown: true
    },

    year_month: {
      sql: `yyyyMMdd`,
      type: `time`
    }

    },
  refreshKey: {
    every: `1 minute`
  }

});
