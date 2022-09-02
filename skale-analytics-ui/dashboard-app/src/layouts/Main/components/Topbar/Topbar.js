import React from 'react';
import { Link as RouterLink } from 'react-router-dom';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import { AppBar, Toolbar } from '@material-ui/core';
import palette from '../../../../theme/palette';
import MenuIcon from '@material-ui/icons/Menu';
import Hidden from '@material-ui/core/Hidden';

const useStyles = makeStyles((theme) => ({
  root: {
    boxShadow: 'none',
    backgroundColor: palette.primary.dark,
    borderBottom: '1px solid #2424a7'
  },
  flexGrow: {
    flexGrow: 1,
  },
  link: {
    'font-family': 'Roboto',
    display: 'flex',
    alignItems: 'center',
    padding: '10px 15px',
    textDecoration: 'none',
    color: palette.text.link,
    borderRadius: '5px',
    transition: 'background-color 250ms cubic-bezier(0.4, 0, 0.2, 1) 0ms',
    '&:hover': {
      textDecoration: 'none',
      color: palette.text.link,
      backgroundColor: 'rgba(213,213,226,.1)',
    },
  },
  signOutButton: {
    marginLeft: theme.spacing(1),
  },
  git: {
    fontStyle: 'normal',
    fontWeight: 'normal',
    fontSize: 16,
    lineHeight: '26px',
    marginLeft: 7,
  },
}));

const Topbar = (props) => {
  const { className, onSidebarOpen, ...rest } = props;

  const classes = useStyles();

  return (
    <AppBar {...rest} className={clsx(classes.root, className)}>
      <Toolbar>
        <RouterLink to="/">
          <img alt="Logo" src="/images/logo/logo.svg" />
        </RouterLink>
        <div className={classes.flexGrow} />
        <Hidden xsDown>
          <a className={classes.link} rel="noopener noreferrer" target="_blank" href="https://github.com/skalenetwork">
            <img alt="GitHub" src="/images/github.svg" />
            <span className={classes.git}>Github</span>
          </a>
          <a className={classes.link} rel="noopener noreferrer" target="_blank" href="https://discord.com/invite/gM5XBy6">
            <img alt="Discord" src="/images/discord.svg" />
            <span className={classes.git}>Discord</span>
          </a>
        </Hidden>
        <Hidden lgUp>
          <a className={classes.link} onClick={onSidebarOpen}><MenuIcon/></a>
        </Hidden>
      </Toolbar>
    </AppBar>
  );
};

Topbar.propTypes = {
  className: PropTypes.string,
  onSidebarOpen: PropTypes.func,
};

export default Topbar;
