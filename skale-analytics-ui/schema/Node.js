cube(`Node`, {
  sql: 'SELECT `id`,' +
      '`name`, ' +
      '`validator_name`,' +
      '`balance`, ' +
      '`status`,`ip`,`address`,`port`, ' +
      '`registration_date`,`last_bounty_call`,' +
      '`called_getBounty_this_epoch`,`validator_id` FROM `mainnet`.`node_stats`' +
      ' order  by id asc ',

  joins: {
    Validator: {
      relationship: `belongsTo`,
      sql: `${Node}.validator_id = ${Validator}.id`
    }
  },

  measures: {
    count: {
      type: `count`,
      drillMembers: [id]
    }
  },

  refreshKey: {
    every: `1 minute`
  },
  dimensions: {
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
      shown: true
    },
    validator_id: {
      sql: `validator_id`,
      type: `number`
    },
    validator_name: {
      sql: `validator_name`,
      type: `string`
    },
    name: {
      sql: `name`,
      type: `string`
    },
    address: {
      sql: `address`,
      type: `string`
    },

    balance: {
      sql: `balance`,
      type: `number`
    },

    called_getBounty_this_epoch: {
      sql: `called_getBounty_this_epoch`,
      type: `string`
    },

    status: {
      sql: `status`,
      type: `string`
    },

    last_bounty_call: {
      sql: `last_bounty_call`,
      type: `time`
    },

    registration_date: {
      sql: `registration_date`,
      type: `time`
    }
  }
});
