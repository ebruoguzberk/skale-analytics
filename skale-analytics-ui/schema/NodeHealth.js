cube(`NodeHealth`, {
  sql: 'SELECT `vi_node_checks`.`id`,\n' +
      '    `vi_node_checks`.`validator_id`,\n' +
      '    `vi_node_checks`.`Name`,\n' +
      '    `vi_node_checks`.`IP`,\n' +
      '    `vi_node_checks`.`Status`,\n' +
      '    `vi_node_checks`.`Address`,\n' +
      '    `vi_node_checks`.`BalanceInWei`,\n' +
      '    `vi_node_checks`.`BaseContainers`,\n' +
      '    `vi_node_checks`.`SgxInfo`,\n' +
      '    `vi_node_checks`.`IsNodeActive`,\n' +
      '    `vi_node_checks`.`SRW_balance`,\n' +
      '    `vi_node_checks`.`BalanceCheck`,\n' +
      '    `vi_node_checks`.`ContainerStatuses`,\n' +
      '    `vi_node_checks`.`ComponentVersions`,\n' +
      '    `vi_node_checks`.`SgxStatus`,\n' +
      '    `vi_node_checks`.`SGXVersion`,\n' +
      '    `vi_node_checks`.`Endpoint`,\n' +
      '    `vi_node_checks`.`Hardware`,\n' +
      '    `vi_node_checks`.`Trusted endpoint` as TrustedEndpoint,\n' +
      '    `vi_node_checks`.`Cores`,\n' +
      '    `vi_node_checks`.`CoreCheck`,\n' +
      '    `vi_node_checks`.`Memory`,\n' +
      '    `vi_node_checks`.`MemoryCheck`,\n' +
      '    `vi_node_checks`.`Storage`,\n' +
      '    `vi_node_checks`.`StorageCheck`,\n' +
      '    `vi_node_checks`.`Swap`,\n' +
      '    `vi_node_checks`.`SwapCheck`,\n' +
      '    `vi_node_checks`.`container_admin`,\n' +
      '    `vi_node_checks`.`container_API`,\n' +
      '    `vi_node_checks`.`nginx`,\n' +
      '    `vi_node_checks`.`container_TransactionManager`,\n' +
      '    `vi_node_checks`.`container_Mysql`,\n' +
      '    `vi_node_checks`.`container_WatchDog`,\n' +
      '    `vi_node_checks`.`container_Bounty`,\n' +
      '    `vi_node_checks`.`container_Filebeat`,\n' +
      '    `vi_node_checks`.`container_Configs`,\n' +
      '    `vi_node_checks`.`container_CLI`,\n' +
      '    `vi_node_checks`.`container_sChain`,\n' +
      '    `vi_node_checks`.`container_IMA`,\n' +
      '    `vi_node_checks`.`container_Lvmpy`,\n' +
      '    `vi_node_checks`.`full_health`,\n' +
      '    `vi_node_checks`.`Filebeat logs` as Filebeat_logs,\n' +
      '    `vi_node_checks`.`BTRFS`,\n' +
      '    `vi_node_checks`.`Val nodes` as Val_nodes ,\n' +
      '    `vi_node_checks`.`Public IP` as Public_IP\n' +
      'FROM `mainnet`.`vi_node_checks`\n',

  joins: {
    ValidatorHealth: {
      relationship: `belongsTo`,
      sql: `${NodeHealth}.validator_id = ${ValidatorHealth}.validator_id`
    }
  },

  measures: {

    Node_count:{
      sql: `id`,
      type: "countDistinct"
    },

  },

  dimensions: {
    node_id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
      shown: true
    },
    Name: {
      sql: `Name`,
      type: `string`
    },
    Status: {
      sql: `status`,
      type: `string`
    },
    Address: {
      sql: `Address`,
      type: `string`
    },
    BalanceInWei: {
      sql: `BalanceInWei`,
      type: `string`
    },BaseContainers: {
      sql: `BaseContainers`,
      type: `string`
    },SgxInfo: {
      sql: `SgxInfo`,
      type: `string`
    },IsNodeActive: {
      sql: `IsNodeActive`,
      type: `string`
    },SRW_balance: {
      sql: `SRW_balance`,
      type: `string`
    },BalanceCheck: {
      sql: `BalanceCheck`,
      type: `string`
    },ContainerStatuses: {
      sql: `ContainerStatuses`,
      type: `string`
    },ComponentVersions: {
      sql: `ComponentVersions`,
      type: `string`
    },SgxStatus: {
      sql: `SgxStatus`,
      type: `string`
    },SGXVersion: {
      sql: `SGXVersion`,
      type: `string`
    },Endpoint: {
      sql: `Endpoint`,
      type: `string`
    },Hardware: {
      sql: `Hardware`,
      type: `string`
    },TrustedEndpoint: {
      sql: `TrustedEndpoint`,
      type: `string`
    },Cores: {
      sql: `Cores`,
      type: `string`
    },CoreCheck: {
      sql: `CoreCheck`,
      type: `string`
    },Memory: {
      sql: `Memory`,
      type: `string`
    },MemoryCheck: {
      sql: `MemoryCheck`,
      type: `string`
    },Storage: {
      sql: `Storage`,
      type: `string`
    },StorageCheck: {
      sql: `StorageCheck`,
      type: `string`
    },Swap: {
      sql: `Swap`,
      type: `string`
    },SwapCheck: {
      sql: `SwapCheck`,
      type: `string`
    },container_admin: {
      sql: `container_admin`,
      type: `string`
    },container_API: {
      sql: `container_API`,
      type: `string`
    },nginx: {
      sql: `nginx`,
      type: `string`
    },container_TransactionManager: {
      sql: `container_TransactionManager`,
      type: `string`
    },container_Mysql: {
      sql: `container_Mysql`,
      type: `string`
    },container_WatchDog: {
      sql: `container_WatchDog`,
      type: `string`
    },container_Bounty: {
      sql: `container_Bounty`,
      type: `string`
    },container_Filebeat: {
      sql: `container_Filebeat`,
      type: `string`
    },container_Configs: {
      sql: `container_Configs`,
      type: `string`
    },container_CLI: {
      sql: `container_CLI`,
      type: `string`
    },container_sChain: {
      sql: `container_sChain`,
      type: `string`
    },container_IMA: {
      sql: `container_IMA`,
      type: `string`
    },container_Lvmpy: {
      sql: `container_Lvmpy`,
      type: `string`
    },full_health: {
      sql: `full_health`,
      type: `string`
    },FilebeatLogs: {
      sql: `Filebeat_logs`,
      type: `string`
    },BTRFS: {
      sql: `BTRFS`,
      type: `string`
    },ValNodes: {
      sql: `Val_nodes`,
      type: `string`
    },PublicIP: {
      sql: `Public_IP`,
      type: `string`
    },


  },

  refreshKey: {
    every: `1 minute`
  }
});
