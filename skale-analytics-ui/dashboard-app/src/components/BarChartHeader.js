import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import { CardHeader, Button } from '@material-ui/core';
import ArrowDropDownIcon from '@material-ui/icons/ArrowDropDown';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';

const useStyles = makeStyles(() => ({
  headerButton: {
    letterSpacing: '0.4px',
  },
}));

const BarChartHeader = (props) => {
  const { title} = props;

  return (
    <CardHeader
      title={title}
    />
  );
};

BarChartHeader.propTypes = {
  className: PropTypes.string,
};

export default BarChartHeader;
