import 'date-fns';
import React from 'react';
import PropTypes from 'prop-types';
import clsx from 'clsx';
import { makeStyles } from '@material-ui/styles';
import Grid from '@material-ui/core/Grid';
import Typography from '@material-ui/core/Typography';
import Tab from '@material-ui/core/Tab';
import Tabs from '@material-ui/core/Tabs';
import palette from '../theme/palette';
import LinearProgress from '@material-ui/core/LinearProgress';
import withStyles from '@material-ui/core/styles/withStyles';
import {useCubeQuery} from "@cubejs-client/react";

const BorderLinearProgress = withStyles((theme) => ({
  root: {
    height: 10,
    borderRadius: 5,
  },
  colorPrimary: {
    backgroundColor: theme.palette.grey[theme.palette.type === 'dark' ? 200 : 700],
  },
  bar: {
    borderRadius: 5,
    backgroundColor: '#1a90ff',
  },
}))(LinearProgress);



const AntTabs = withStyles({
  root: {
    borderBottom: `1px solid ${palette.primary.main}`,
  },
  indicator: {
    backgroundColor: `${palette.primary.main}`,
  },
})(Tabs);


const AntTab = withStyles((theme) => ({
  root: {
    textTransform: 'none',
    minWidth: 25,
    fontSize: 12,
    fontWeight: theme.typography.fontWeightRegular,
    marginRight: theme.spacing(0),
    color: palette.primary.white,
    opacity: 0.6,
    '&:hover': {
      color: `${palette.primary.main}`,
      opacity: 1,
    },
    '&$selected': {
      color: `${palette.primary.main}`,
      fontWeight: theme.typography.fontWeightMedium,
      outline: 'none',
    },
    '&:focus': {
      color: `${palette.primary.main}`,
      outline: 'none',
    },
  },
  selected: {},
}))((props) => <Tab disableRipple {...props} />);
const useStyles = makeStyles((theme) => ({
  root: {},
  row: {
    marginTop: theme.spacing(1),
  },
  spacer: {
    flexGrow: 1,
  },
  importButton: {
    marginRight: theme.spacing(1),
  },
  exportButton: {
    marginRight: theme.spacing(1),
  },
  searchInput: {
    marginRight: theme.spacing(1),
  },
  formControl: {
    margin: 25,
    fullWidth: true,
    display: 'flex',
    wrap: 'nowrap',
  },
  date: {
    marginTop: 3,
  },
  range: {
    marginTop: 13,
  },
  title: {
    fontWeight: 500,
  },
}));

const ValidatorTopBar = (props) => {
  const {
    className,
    query,
    ...rest
  } = props;

  const classes = useStyles();
  const load = useCubeQuery(query);
  if (load.error) {
    return <pre>{load.error.toString()}</pre>;
  }
  if (!load.resultSet) {
    return null;
  }
  if (load.resultSet) {
    let validator = load.resultSet.tablePivot()[0];
    const val_name = validator['Validator.name'];
    const val_address = validator['Validator.address'];
    const val_fee = validator['Validator.validator_fee'];
    const val_next_epoch = validator['Validator.delegated_next_epoch'];
    const val_needed_next_epoch = validator['Validator.del_needed_next_epoch_node'];
    const border = 100 - Math.floor(validator["Validator.del_needed_for_next_node_dim"]/20000000*100);

    return (
        <div {...rest} className={clsx(classes.root, className)}>
          <Grid container spacing={4}>
            <Grid item lg={5} sm={12} xl={5} xs={12} m={6}>
              <Typography variant="h1" gutterBottom>{val_name}</Typography>
              <Typography color="textSecondary" gutterBottom variant="body2">
                {val_address}
              </Typography>
            </Grid>
            <Grid item lg={3} sm={12} xl={3} xs={12} m={6}>
              <Typography variant="h3" gutterBottom>Commission Fee</Typography>
              <Typography color="textSecondary" gutterBottom variant="body2" align="left">
                {val_fee} %
              </Typography>
            </Grid>
            <Grid item lg={4} sm={8} xl={4} xs={12} m={4}>
              <div className={classes}>
                <Grid container justify="space-between">
                  <Typography variant="subtitle1" display="inline">{val_next_epoch}</Typography>
                  <Typography variant="subtitle1" display="inline">{val_needed_next_epoch}</Typography>
                </Grid>
                <BorderLinearProgress variant="determinate" value={border}/>
                <Typography className={classes.padding}/>
                <Grid container justify="space-between">
                  <Typography color="textSecondary" gutterBottom variant="body2" display="inline">
                    Staking total next epoch
                  </Typography>
                  <Typography color="textSecondary" gutterBottom variant="body2" display="inline">
                    Stake for next node
                  </Typography>
                </Grid>
              </div>
            </Grid>
          </Grid>
        </div>
    );
  }
};

ValidatorTopBar.propTypes = {
  className: PropTypes.string,
};

export default ValidatorTopBar;
