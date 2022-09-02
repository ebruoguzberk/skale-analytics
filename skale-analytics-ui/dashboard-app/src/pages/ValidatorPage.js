import React from 'react';
import { useParams } from 'react-router-dom';
import { makeStyles } from '@material-ui/styles';
import { Grid } from '@material-ui/core';
import KPIChart from '../components/KPIChart';
import TableChart from "../components/TableChart";
import ValidatorTopBar from "../components/ValidatorTopBar";
import palette from "../theme/palette";
import ValidatorSearch from "../components/ValidatorSearch";
import BarChartDim from "../components/BarChartDim";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
    backgroundColor: palette.primary.medium,
  }
}));

const ValidatorPage = (props) => {

  const classes = useStyles();
  let { id } = useParams();

  const delegation_query = {
    measures: [
      "Delegations.amount"
    ],
    timeDimensions: [
      {
        "dimension": "Delegations.created"
      }
    ],
    dimensions: [
      "Delegations.id",
      "Delegations.status",
      "Delegations.info",
    ],
    filters: [
      {
        "dimension": "Delegations.status",
        "operator": "contains",
        "values": [
          "PROPOSED"
        ]
      },
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      }
    ], renewQuery: true
  }
  const rewards = {
    dimensions: [],
    timeDimensions: [],
    order: {},
    measures: [
      "Rewards.claimed",
      "Rewards.to_date",
      "Rewards.unclaimed"
    ],
    filters: [
      {
        dimension: "Rewards.type",
        operator: "equals",
        values: ["VALIDATOR"]
      },
      {
        dimension: 'Rewards.validator_id',
        operator: 'equals',
        values: [`${id}`],
      }
    ], renewQuery: true
  }
  const cards = [
    {
      title: 'Total Staked',
      query: {
        measures: ['Validator.Total_Staked'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.25
    },
    {
      title: 'Expected Fee this epoch',
      query: {
        measures: ['Validator.expected_validator_fee_this_epoch'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.5,
    }
  ];
  const qrymonthlyreward = {
    dimensions: [
      "MonthlyRewards.year_month"
    ],
    timeDimensions: [],
    order: {
      "MonthlyRewards.year_month": "asc"
    },
    measures: [
      "MonthlyRewards.validator_reward"
    ],
    filters: [
      {
        dimension: 'MonthlyRewards.validator_id',
        operator: 'equals',
        values: [`${id}`],
      },
    ], renewQuery: true
  }

  const cards_nodes = [
    {
      title: 'Active Nodes',
      query: {
        measures: ['Validator.active_nodes_in_network'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.5,
    },
    {
      title: 'Linked Nodes',
      query: {
        measures: ['Validator.linkedNodesCount'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.5,
    },{
      title: 'Shut down Node next epoch',
      query: {
        measures: ['Validator.NodeDanger'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.5,
    },
    {
      title: 'Register Node next epoch',
      query: {
        measures: ['Validator.missing_registered_nodes'],
        filters: [
          {
            dimension: 'Validator.id',
            operator: 'equals',
            values: [`${id}`],
          },
        ], renewQuery: true
      },
      duration: 1.5,
    }
  ];
  const tableQuery = {

    measures: ['Delegations.amount'],
    timeDimensions: [],
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
    ],
    dimensions: ['Delegations.status'], renewQuery: true
  };

  const table2Query = {
    dimensions: [
      "Delegations.next_epoch_status"
    ],
    timeDimensions: [],
    order: {
      "Delegations.amount": "desc"
    },
    measures: [
      "Delegations.amount"
    ],
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
      {
        dimension: "Delegations.next_epoch_status",
        operator: "set",
        values: []
      }
    ]
  };


  const nodeQuery =   {
    measures: [],
    timeDimensions: [],
    filters: [
      {
        dimension: "Node.validator_id",
        operator: "equals",
        values: [`${id}`],
      }
    ],
    dimensions: [
      "Node.id",
      "Node.name",
      "Node.address",
      "Node.last_bounty_call",
      "Node.called_getBounty_this_epoch",
      "Node.status",
      "Node.registration_date",
      "Node.balance"
    ], renewQuery: true
  };

  const query = {
    measures: [],
    timeDimensions: [],
    filters: [
      {
        dimension: "Validator.id",
        operator: "equals",
        values: [`${id}`],
      }
    ],
    dimensions: [
      "Validator.name",
      "Validator.nodeOperator",
      "Validator.validator_fee",
      "Validator.minimum_delegation",
      "Validator.address",
      "Validator.del_needed_next_epoch_node",
      "Validator.delegated_next_epoch",
      "Validator.del_needed_for_next_node_dim"
    ], renewQuery: true
  };

  return (

        <div className={classes.root}>
          <ValidatorSearch/>
          <Grid item>
              <ValidatorTopBar query={query}/>
          </Grid>
          <Grid container spacing={4}>
            {cards.map((item, index) => {
              return (
                  <Grid key={item.title + index} item lg={2} sm={4} xl={5} xs={12}>
                    <KPIChart {...item} />
                  </Grid>
              );
            })}
            {cards_nodes.map((item, index) => {
              return (
                  <Grid key={item.title + index} item lg={2} sm={4} xl={5} xs={12}>
                    <KPIChart {...item} />
                  </Grid>
              );
            })}
            <Grid item lg={4} md={6} xl={8} xs={12}>
              <TableChart query={rewards} title={"Rewards"} isOpposite={true} />
            </Grid>
            <Grid item lg={8} md={6} xl={8} xs={12}>
              <BarChartDim query={qrymonthlyreward} title={"Rewards Monthly"}/>
            </Grid>
            <Grid item lg={6} md={6} xl={8} xs={12}>
              <TableChart query={tableQuery} title={"Delegation States"} />
            </Grid>
            <Grid item lg={6} md={6} xl={8} xs={12}>
            <TableChart query={table2Query} title={"Delegation next epoch"} />
            </Grid>

            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={delegation_query} title={"Pending Delegations"} />
            </Grid>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={nodeQuery} title={"Validator Nodes"} />
            </Grid>

          </Grid>
        </div>
    );
};

export default ValidatorPage;
