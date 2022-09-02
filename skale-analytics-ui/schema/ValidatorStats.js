cube(`Validator`, {
  sql: `SELECT *,fee_rate/10 validator_fee, 
floor(expected_earned_rewards_to_date) earned_rewards,
floor(Total_Amount_Current_Delegations) Total_Staked,
format(floor(del_needed_for_next_node),0)  del_needed_next_epoch_node,
format(floor(Total_Amount_Delegated_Next_Epoch),0)  delegated_next_epoch,
case when (active_nodes_in_network - active_nodes_needed_next_epoch)>0 then 
(active_nodes_in_network - active_nodes_needed_next_epoch) else null end as NodeDanger
FROM mainnet.validator_stats`,

  joins: {
  },

  measures: {


    Validator_count:{
      sql: `id`,
      type: "countDistinct"
    },

    Total_Staked:{
      sql: `Total_Staked`,
      type: `max`
    },

    balance: {
      sql: `balance`,
      type: `max`
    },

    gasusedbyvalidatoraccount: {
      sql: `${CUBE}.\`gastUsedByValidatorAccount\``,
      type: `max`
    },

    linkedNodesCount: {
      sql: `linked_nodes_count`,
      type: `max`
    },

    active_nodes_in_network: {
      sql: `active_nodes_in_network`,
      type: `max`
    },

    pending_amount: {
      sql: `Total_Amount_In_Proposed_Status`,
      type: `max`
    },

    expected_validator_fee_this_epoch:{
      sql: `expected_validator_fee_this_epoch`,
      type: `max`
    },

    del_needed_for_next_node: {
      sql: `del_needed_for_next_node`,
      type: `max`
    },

    Total_Amount_Delegated_Next_Epoch:{
      sql: `Total_Amount_Delegated_Next_Epoch`,
      type: `max`
    },
    validator_delegation:{
      sql: `validator_delegation`,
      type: `sum`
    },
    del_needed_for_next_node_with_proposed:{
      sql: `del_needed_for_next_node_with_proposed`,
      type: `max`
    },
    NodeDanger:{
      sql: `NodeDanger`,
      type: `max`
    },

    received_fee:{
      sql: `received_validator_fee_to_date`,
      type: `max`
    },
    unclaimed_fee:{
      sql: `unclaimed_fee`,
      type: `max`
    },

    claimed_fee:{
      sql: `claimed_fee`,
      type: `max`
    },

    missing_registered_nodes: {
      sql: `missing_registered_nodes`,
      type: `max`
    },
    activate_undelegation_probability_by_next_epoch: {
      sql: `Total_Amount_In_Delegated_Activate_CanBeUndelegated`,
      type: `max`
    },
  },

  dimensions: {
    address: {
      sql: `address`,
      type: `string`
    },

    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
      shown: true
    },

    name: {
      sql: `name`,
      type: `string`
    },

    nodeOperator: {
      sql: `node_operator`,
      type: `string`
    },

    validator_fee: {
      sql: `validator_fee`,
      type: `string`
    },

    minimum_delegation: {
      sql: `mdr`,
      type: `string`
    },

    del_needed_next_epoch_node: {
      sql: `del_needed_next_epoch_node`,
      type: `number`
    },

    delegated_next_epoch: {
      sql: `delegated_next_epoch`,
      type: `number`
    },

    del_needed_for_next_node_dim: {
      sql: `del_needed_for_next_node`,
      type: `number`
    }
  },

  refreshKey: {
    every: `1 minute`
  }
});
