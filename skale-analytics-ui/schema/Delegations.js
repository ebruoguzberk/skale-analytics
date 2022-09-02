cube(`Delegations`, {
  sql: `SELECT mainnet.skale_delegations.*, DATE_FORMAT(FROM_UNIXTIME(created),'%Y-%m-%d') as createddate,
(CASE
            WHEN (DATE_FORMAT(from_unixtime(created), '%Y-%m') = DATE_FORMAT(CURDATE(), '%Y-%m')) 
            then 'this epoch'
           WHEN
                (DATE_FORMAT(from_unixtime(created), '%Y-%m') = DATE_FORMAT((CURDATE() + INTERVAL - (1) MONTH),
                        '%Y-%m'))
            THEN
                'previous epoch'
           ELSE null
           
        END) AS \`epoch\`
        , DATE_FORMAT(FROM_UNIXTIME(created),'%d') as for_chart
        ,CASE
            WHEN (status = 'UNDELEGATION_REQUESTED') and ( PERIOD_DIFF( month(LAST_DAY(CAST(DATE_FORMAT(FROM_UNIXTIME(created), '%Y-%m-%d %h:%i:%s') AS DATETIME)) + INTERVAL 1 DAY)
                ,month((LAST_DAY(CURDATE()) + INTERVAL 1 DAY))) % delegation_period) = 0
            THEN
                'UnDelegated'
            WHEN (status = 'ACCEPTED' || status = 'DELEGATED' || ((status = 'UNDELEGATION_REQUESTED') 
            and ( PERIOD_DIFF( month(LAST_DAY(CAST(DATE_FORMAT(FROM_UNIXTIME(created), '%Y-%m-%d %h:%i:%s') AS DATETIME)) + INTERVAL 1 DAY)
                ,month((LAST_DAY(CURDATE()) + INTERVAL 1 DAY))) % delegation_period) > 0))
            THEN
                'Delegated'
            WHEN (status = 'PROPOSED')
            THEN 
                'Pending'
            ELSE NULL
        END next_epoch_status,
        case when info = 'Activate' then 'Activate'
        when info = 'Delegation UI' then 'Delegation UI'
        else 'other' end source,
        CASE WHEN em.address IS NOT NULL and em.holder_address IS NOT NULL 
        THEN em.holder_address else mainnet.skale_delegations.holder_address end holder, 
        concat("Escrow: ", em.address) as escrow_address
FROM mainnet.skale_delegations
LEFT OUTER JOIN mainnet.skale_contract_proxy em on em.address = mainnet.skale_delegations.holder_address
order by createddate`,

  joins: {
    Validator: {
      relationship: `belongsTo`,
      sql: `${Delegations}.validator_id = ${Validator}.id`
    }
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id]
    },
    
    amount: {
      sql: `amount`,
      type: `sum`
    }
  },
  
  dimensions: {

    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
      shown: true
    },

    validator_id:{
      sql: `validator_id`,
      type: `string`
    },

    name: {
      sql: `name`,
      type: `string`
    },

    created: {
      sql: `createddate`,
      type: `time`
    },

    info: {
      sql: `info`,
      type: `string`
    },

    source: {
      sql: `source`,
      type: `string`
    },
    holder_address:{
      sql: `holder`,
      type: `string`
    },
    escrow_address:{
      sql: `escrow_address`,
      type: `string`
    },
    status: {
      sql: `status`,
      type: `string`
    },
    next_epoch_status: {
      sql: `next_epoch_status`,
      type: `string`
    },

    epoch: {
      sql: `epoch`,
      type: `string`
    },

    for_chart: {
      sql: `for_chart`,
      type: `string`
    }

    },
  refreshKey: {
    every: `1 minute`
  }

});
