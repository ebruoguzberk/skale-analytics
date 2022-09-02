import React from 'react';
import { Doughnut } from 'react-chartjs-2';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles, useTheme } from '@material-ui/styles';
import { Card, CardHeader, CardContent, Divider, Typography } from '@material-ui/core';
import { useCubeQuery } from '@cubejs-client/react';
import CircularProgress from '@material-ui/core/CircularProgress';
import { DoughnutOptions } from '../helpers/DoughnutOptions.js';
import palette from "../theme/palette";

const useStyles = makeStyles((theme) => ({
  root: {
    height: '100%',
  },
  chartContainer: {
    marginTop: theme.spacing(3),
    position: 'relative',
    height: '300px',
  },
  stats: {
    marginTop: theme.spacing(2),
    display: 'flex',
    justifyContent: 'center',
  },
  status: {
    textAlign: 'center',
    padding: theme.spacing(1),
  },
  title: {
    color: theme.palette.text.secondary,
    paddingBottom: theme.spacing(1),
  },
  statusIcon: {
    color: theme.palette.icon,
  },
}));

const DoughnutChart = (props) => {
  const { className, query, ...rest } = props;

  const classes = useStyles();
  const theme = useTheme();

  const { resultSet, error, isLoading } = useCubeQuery(query);
  if (isLoading) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <CircularProgress color="secondary" />
      </div>
    );
  }
  if (error) {
    return <pre>{error.toString()}</pre>;
  }
  if (!resultSet) {
    return null;
  }
  if (resultSet) {
    const COLORS_SERIES = [
      palette.secondary.secondary4,
      palette.secondary.main,
      palette.secondary.light,
      palette.secondary.lighten,
      palette.secondary.secondary5,
      palette.secondary.secondary6,
      palette.secondary.secondary7,
      palette.secondary.secondary8,
      palette.secondary.secondary9,
      palette.secondary.secondary10,
      palette.secondary.secondary11,
      palette.secondary.secondary12,
      palette.secondary.secondary13,
      palette.secondary.secondary14,
      palette.secondary.secondary15,
      palette.secondary.secondary16,
      palette.secondary.secondary17,
      palette.secondary.secondary18,
      palette.secondary.secondary19
    ];
    const data = {
      labels: resultSet.categories().map((c) => c.category),
      datasets: resultSet.series().map((s) => ({
        label: s.title,
        data: s.series.map((r) => r.value),
        backgroundColor: COLORS_SERIES,
        hoverBackgroundColor: COLORS_SERIES,
      })),
    };
    const reducer = (accumulator, currentValue) => accumulator + currentValue;
    return (
      <Card {...rest} className={clsx(classes.root, className)}>
        <CardHeader title="Rewards-to-Date by Validator" />
        <Divider />
        <CardContent>
          <div className={classes.chartContainer}>
            <Doughnut data={data} options={DoughnutOptions} />
          </div>

        </CardContent>
      </Card>
    );
  }
};

DoughnutChart.propTypes = {
  className: PropTypes.string,
};

export default DoughnutChart;
