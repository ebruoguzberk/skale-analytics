import React from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import { Card, CardContent, Divider } from '@material-ui/core';
import BarChartHeader from './BarChartHeader';
import ChartRenderer from './ChartRenderer';

const useStyles = makeStyles(() => ({
  root: {},
  chartContainer: {
    position: 'relative',
    padding: '0',
  },
}));

const BarChartDim = (props) => {
  const { className, query, dates,title, ...rest } = props;
  const classes = useStyles();

  let queryWithDate = {
    ...query
  };

  return (
    <Card {...rest} className={clsx(classes.root, className)}>
      <BarChartHeader title={title} />
      <Divider />
      <CardContent>
        <div className={classes.chartContainer}>
          <ChartRenderer vizState={{ query: queryWithDate, chartType: 'bar' }} />
        </div>
      </CardContent>
    </Card>
  );
};

BarChartDim.propTypes = {
  className: PropTypes.string,
};

export default BarChartDim;
