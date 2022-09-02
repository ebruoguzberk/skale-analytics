import React from 'react';
import { useParams } from 'react-router-dom';
import { makeStyles } from '@material-ui/styles';
import { Grid } from '@material-ui/core';
import TableChart from "../components/TableChart";
import palette from "../theme/palette";
import DelegatorSearch from "../components/DelegatorSearch";
import clsx from "clsx";
import Typography from "@material-ui/core/Typography";
import DoughnutChart from "../components/DoughnutChart";
import ValueChart from "../components/ValueChart";
import BarChartDim from "../components/BarChartDim";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
    backgroundColor: palette.primary.medium,
  }
}));

const DelegatorPage = (props) => {

  const classes = useStyles();
  let { address } = useParams();

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
      "Validator.name",
      "Delegations.validator_id"
    ],
    filters: [
      {
        dimension: 'Delegations.holder_address',
        operator: 'equals',
        values: [`${address}`],
      }
    ],
    renewQuery: true
  }


  const escrow_query = {
    dimensions: [
      "Delegations.escrow_address"
    ],
    filters: [
      {
        dimension: 'Delegations.holder_address',
        operator: 'equals',
        values: [`${address}`],
      }
    ],
    renewQuery: true
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
        dimension: 'Rewards.address',
        operator: 'equals',
        values: [`${address}`],
      }
    ], renewQuery: true
  }

  const rewards_pie = {
    dimensions: [
      "Validator.name"
    ],
    timeDimensions: [],
    order: {
        "Validator.name":"asc"},
    filters: [
      {
        dimension: 'Rewards.address',
        operator: 'equals',
        values: [`${address}`],
      }
    ],
    measures: [
      "Rewards.to_date"
    ], renewQuery: true
  }
  const qrymonthlyreward_val = {
    dimensions: [
      "Validator.name"
    ],
    timeDimensions: [{
      "dimension": "MonthlyDelegatorStats.year_month",
      "granularity": "month"
    }],
    order: {
      "MonthlyDelegatorStats.epoch": "asc",
      "Validator.name":"asc"
    },
    measures: [
      "MonthlyDelegatorStats.TokenHolder_Reward"
    ],
    filters: [
      {
        dimension: 'MonthlyDelegatorStats.holder_address',
        operator: 'equals',
        values: [`${address}`],
      }
    ], renewQuery: true
  }


  const qrymonthlyreward = {
    dimensions: [
    ],
    timeDimensions: [{
      "dimension": "MonthlyDelegatorStats.year_month",
      "granularity": "month"
    }],
    order: {
      "MonthlyDelegatorStats.epoch": "asc",
      "Validator.name":"asc"
    },
    measures: [
      "MonthlyDelegatorStats.TokenHolder_Reward"
    ],
    filters: [
      {
        dimension: 'MonthlyDelegatorStats.holder_address',
        operator: 'equals',
        values: [`${address}`],
      }
    ], renewQuery: true
  }

  const tableQuery = {

    measures: ['Delegations.amount'],
    timeDimensions: [],
    filters: [
      {
        dimension: 'Delegations.holder_address',
        operator: 'equals',
        values: [`${address}`],
      }
    ],
    dimensions: [
        'Delegations.status'
    ]
    , renewQuery: true
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
        dimension: 'Delegations.holder_address',
        operator: 'equals',
        values: [`${address}`],
      },
      {
        dimension: "Delegations.next_epoch_status",
        operator: "set",
        values: []
      }
    ]
    , renewQuery: true
  };

  return (

        <div className={classes.root}>
          <DelegatorSearch/>
          <Grid container spacing={4}>
            <Grid item lg={12} sm={12} xl={12} xs={12} m={12}>
              <Typography variant="h1" gutterBottom>Token Holder</Typography>
              <Typography color="textSecondary" gutterBottom variant="body2">
                {address}
                <ValueChart query={escrow_query}/>
              </Typography>
            </Grid>
            <Grid item lg={4} md={6} xl={2} xs={12} >
              <TableChart query={rewards} title={"Rewards"} isOpposite={true} />
            </Grid>
            <Grid item lg={8} md={6} xl={6} xs={12} >
              <BarChartDim query={qrymonthlyreward} title={"Rewards Monthly"} />
            </Grid>
            <Grid item lg={4} md={6} xl={4} xs={12}>
              <DoughnutChart query={rewards_pie} title={"Rewards per Validator"} />
            </Grid>
            <Grid item lg={8} md={6} xl={6} xs={12} >
              <BarChartDim query={qrymonthlyreward_val} title={"Rewards Monthly by Validator"} />
            </Grid>
            <Grid item lg={6} md={6} xl={6} xs={12}>
              <TableChart query={tableQuery} title={"Delegation States"} />
            </Grid>
            <Grid item lg={6} md={6} xl={6} xs={12}>
            <TableChart query={table2Query} title={"Delegation next epoch"} />
            </Grid>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={delegation_query} title={"Delegations"} />
            </Grid>
          </Grid>
        </div>
    );
};

export default DelegatorPage;
