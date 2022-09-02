import React from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import { Divider, Drawer } from '@material-ui/core';
import DashboardIcon from '@material-ui/icons/Dashboard';
import StorageIcon from '@material-ui/icons/Storage';
import FormatListBulletedIcon from '@material-ui/icons/FormatListBulleted';

import {  SidebarNav } from './components';

const useStyles = makeStyles((theme) => ({
  drawer: {
    borderRight: '1px solid ' + theme.palette.blue,
    width: 200,
    
    [theme.breakpoints.up('lg')]: {
      marginTop: 64,
      height: 'calc(100% - 64px)',
    },
  },
  root: {
    backgroundColor: theme.palette.primary.dark,
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
    padding: theme.spacing(4),
  },
  divider: {
    margin: theme.spacing(4, 0, 1),
    backgroundColor: theme.palette.blue,
  },
  nav: {
    marginBottom: theme.spacing(2),
  },
}));

const Sidebar = (props) => {
  const { open, variant, onClose, className, ...rest } = props;

  const classes = useStyles();

  const pages = [
    {
      title: 'Mainnet',
      href: '/dashboard',
      icon: <DashboardIcon />,
    },
    {
      title: 'Validators',
      href: '/validators',
      icon: <StorageIcon />,
    },
    {
      title: 'TokenHolders',
      href: '/tokenholders',
      icon: <FormatListBulletedIcon />,
    },

  ];

  return (
    <Drawer anchor="left" classes={{ paper: classes.drawer }} onClose={onClose} open={open} variant={variant}>
      <div {...rest} className={clsx(classes.root, className)}>
        <Divider className={classes.divider} />
        <SidebarNav className={classes.nav} pages={pages} />
      </div>
    </Drawer>
  );
};

Sidebar.propTypes = {
  className: PropTypes.string,
  onClose: PropTypes.func,
  open: PropTypes.bool.isRequired,
  variant: PropTypes.string.isRequired,
};

export default Sidebar;
