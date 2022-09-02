cube(`Rewards`, {
  sql: `SELECT *,case when \`type\`='VALIDATOR' then validator_id else null end val_id FROM mainnet.skale_rewards`,
  
  joins: {
    Validator: {
      relationship: `belongsTo`,
      sql: `${Rewards}.validator_id = ${Validator}.id`
    }
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [validator_id]
    },
    unclaimed:{
      sql: `unclaimed_rewards`,
      type: `sum`
    },
    claimed:{
      sql: `claimed_rewards`,
      type: `sum`
    },
    to_date:{
      sql: `rewards_to_date`,
      type: `sum`
    },

  },
  
  dimensions: {

    id: {
      sql: `id`,
      type: `string`,
      primaryKey: true

    },
    validator_id: {
        sql: `validator_id`,
        type: `string`

    },
    address: {
      sql: `address`,
      type: `string`
    },
    
    type: {
      sql: `type`,
      type: `string`
    },
    val_id: {
      sql: `val_id`,
      type: `string`
    },

    escrow_address: {
      sql: `escrow_address`,
      type: `string`
    }
  }, refreshKey: {
    every: `1 minute`
  }
});
