import React from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import ChartRenderer from './ChartRenderer';

const useStyles = makeStyles(() => ({
  root: {},
  chartContainer: {
    position: 'relative',
    padding: '19px 0',
    overflowX: 'scroll'
  },
}));

const ValueChart = (props) => {
  const { className, query,title, isOpposite, ...rest  } = props;
  const classes = useStyles();
  let typeoftbl =  'value'

  return (
          <ChartRenderer vizState={{ query: query, chartType: typeoftbl }} />
  );
};

ValueChart.propTypes = {
  className: PropTypes.string,
};

export default ValueChart;
