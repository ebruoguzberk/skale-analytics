cube(`ChainHealth`, {
  sql: 'SELECT `schain_health_checks`.`# Node ID` node_id,\n' +
      '    `schain_health_checks`.`Schain Name` schain_name,\n' +
      '    `schain_health_checks`.`HTTP`,\n' +
      '    `schain_health_checks`.`HTTPs`,\n' +
      '    `schain_health_checks`.`Blocks`,\n' +
      '    `schain_health_checks`.`Data directory` data_directory,\n' +
      '    `schain_health_checks`.`DKG`,\n' +
      '    `schain_health_checks`.`Config file` config_file,\n' +
      '    `schain_health_checks`.`Volume`,\n' +
      '    `schain_health_checks`.`Container`,\n' +
      '    `schain_health_checks`.`IMA`,\n' +
      '    `schain_health_checks`.`Firewall`,\n' +
      '    `schain_health_checks`.`RPC`\n' +
      ' FROM `mainnet`.`schain_health_checks` \n ' +
      ' INNER JOIN `mainnet`.`schain_info` si on `schain_health_checks`.`Schain Name` = si.`# Name` \n' +
      ' WHERE si.`LIVE`= 1 ',

  joins: {
    Node: {
      relationship: `belongsTo`,
      sql: `${Node}.id = ${ChainHealth}.node_id`
    }
  },

  measures: {

    Node_count:{
      sql: `node_id`,
      type: "countDistinct"
    },

  },

  dimensions: {
    node_id: {
      sql: `node_id`,
      type: `string`,
      primaryKey: true,
      shown: true,
      title: `node_id`
    },
    schain_name: {
      sql: `schain_name`,
      type: `string`,
      primaryKey: true,
      shown: true,
      title: `schain_name`
    },
    HTTP: {
      sql: `HTTP`,
      type: `string`,
      title: `https`
    },
    HTTPs: {
      sql: `HTTPs`,
      type: `string`
    },
    Blocks: {
      sql: `Blocks`,
      type: `string`
    },
    data_directory: {
      sql: `data_directory`,
      type: `string`
    },
    DKG: {
      sql: `DKG`,
      type: `string`
    },
    config_file: {
      sql: `config_file`,
      type: `string`
    },
    Volume: {
      sql: `Volume`,
      type: `string`
    },
    Container: {
      sql: `Container`,
      type: `string`
    },
    IMA: {
      sql: `IMA`,
      type: `string`
    },
    Firewall: {
      sql: `Firewall`,
      type: `string`
    },
    RPC: {
      sql: `RPC`,
      type: `string`
    }
  },

  refreshKey: {
    every: `1 minute`
  }
});
