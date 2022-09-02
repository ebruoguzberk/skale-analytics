cube(`ChainInfo`, {
  sql: 'SELECT `schain_info`.`# Name` as name,\n' +
      '    `schain_info`.`Type` as type,\n' +
      '    `schain_info`.`Creation time` as creation_type,\n' +
      '    `schain_info`.`Owner` as owner,\n' +
      '    `schain_info`.`Chain ID` as chain_id,\n' +
      '    `schain_info`.`Rotation ID` as rotation_id,\n' +
      '    `schain_info`.`Nodes` as nodes\n' +
      'FROM `mainnet`.`schain_info` WHERE `Live` = 1',

  joins: {
    ChainHealth: {
      relationship: `belongsTo`,
      sql: `${ChainInfo}.name = ${ChainHealth}.schain_name`
    }
  },

  measures: {

    TotalLiveChains:{
      sql: `name`,
      type: "countDistinct"
    },

  },

  dimensions: {
    name: {
      sql: `name`,
      type: `string`,
      primaryKey: true,
      shown: true
    },
    Type: {
      sql: `Type`,
      type: `string`
    },
    creation_type: {
      sql: `creation_type`,
      type: `string`
    },
    owner: {
      sql: `owner`,
      type: `string`
    },
    chain_id: {
      sql: `chain_id`,
      type: `string`
    },
    rotation_id: {
      sql: `rotation_id`,
      type: `string`
    },
    nodes: {
      sql: `nodes`,
      type: `string`
    }
  },

  refreshKey: {
    every: `1 minute`
  }
});
