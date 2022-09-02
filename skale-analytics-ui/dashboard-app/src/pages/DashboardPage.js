import React from 'react';
import { Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/styles';
import KPIChart from '../components/KPIChart';
import BarChart from '../components/BarChart.js';
import TableChart from '../components/TableChart.js';

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
  },
}));

const cards = [
  {
    title: 'Total Staked',
    query: { measures: ["NetworkStats.total_staked"] , renewQuery: true},
    duration: 2.25,
  },
  {
    title: 'Unique Delegators',
    query: { measures: ['NetworkStats.current_unique_delegators'], renewQuery: true },
    duration: 1.75,
  },
  {
    title: 'Delegation Count',
    query: { measures: ['NetworkStats.CurrentDelegationCount'], renewQuery: true },
    duration: 1.75,
  },
  {
    title: 'Validator Count',
    query: { measures: ['NetworkStats.validator_count'] , renewQuery: true},
    duration: 0.75,
  },
  {
    title: 'Active Nodes',
    query: { measures: ['NetworkStats.ActiveNodes'] , renewQuery: true},
    duration: 0.75,
  },
  {
    title: 'Avg Bounty Per Node',
    query: {
      "measures": [
        "MonthlyBounty.inflation_epoch_per_node"
      ],
      "timeDimensions": [],
      "dimensions": [
        "MonthlyBounty.this_epoch"
      ],
      "filters": [
        {
          "dimension": "MonthlyBounty.this_epoch",
          "operator": "contains",
          "values": [
            "1"
          ]
        }
      ], renewQuery: true
    },
    duration: 1.50,
  }
];
const barChartQuery = {

  measures: [
    "MonthlyCumulative.Amount"
  ],
  timeDimensions: [
    {
      dimension: "MonthlyCumulative.created",
      granularity: "day",
      dateRange: [
        "2020-09-23",
        new Date().toISOString().split('T')[0]
      ]
    }
  ],
  order: {},
  dimensions: [],
  filters: [],
  renewQuery: true
};
const tableQuery = {
  measures: ['Delegations.amount'],
  timeDimensions: [],
  filters: [],
  dimensions: ['Delegations.status'],
  renewQuery: true
};

const Dashboard = () => {
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <Grid container spacing={4}>
        {cards.map((item, index) => {
          return (
            <Grid key={item.title + index} item lg={2} sm={6} xl={2} xs={12}>
              <KPIChart {...item} />
            </Grid>
          );
        })}
        <Grid item lg={8} md={12} xl={9} xs={12}>
          <BarChart query={barChartQuery} title={"Delegations Over Time"}/>
        </Grid>
        <Grid item lg={4} md={6} xl={3} xs={12}>
          <TableChart query={tableQuery} title={"Delegation States"} />
        </Grid>
      </Grid>
    </div>
  );
};

export default Dashboard;
