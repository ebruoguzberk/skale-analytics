cube(`ValidatorHealth`, {
  sql: 'SELECT validator_id, status FROM mainnet.vi_validator_ready',

  joins: {
    Validator: {
      relationship: `belongsTo`,
      sql: `${ValidatorHealth}.validator_id = ${Validator}.id`
    }
  },

  measures: {

    Validator_count:{
      sql: `validator_id`,
      type: "countDistinct"
    },

  },

  dimensions: {
    status: {
      sql: `status`,
      type: `string`
    },

    validator_id: {
      sql: `validator_id`,
      type: `number`,
      primaryKey: true,
      shown: true
    }
  },

  refreshKey: {
    every: `1 minute`
  }
});
