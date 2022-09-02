import React from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import {Card, CardContent, CardHeader, Divider} from '@material-ui/core';
import ChartRenderer from './ChartRenderer';

const useStyles = makeStyles(() => ({
  root: {},
  chartContainer: {
    position: 'relative',
    padding: '19px 0',
    overflowX: 'scroll'
  },
}));

const TableChart = (props) => {
  const { className, query,title, isOpposite, ...rest  } = props;
  const classes = useStyles();
  let typeoftbl =  'table'
  if(isOpposite)
      typeoftbl = 'table_opposite_xy'

  return (
    <Card {...rest} className={clsx(classes.root, className)}>
        <CardHeader title={title}/>
      <Divider />
      <CardContent>
        <div className={classes.chartContainer}>
          <ChartRenderer vizState={{ query: query, chartType: typeoftbl }} />
        </div>
      </CardContent>
    </Card>
  );
};

TableChart.propTypes = {
  className: PropTypes.string,
};

export default TableChart;
