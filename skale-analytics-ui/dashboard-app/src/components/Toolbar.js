import 'date-fns';
import React from 'react';
import PropTypes from 'prop-types';
import clsx from 'clsx';
import { makeStyles } from '@material-ui/styles';
import Grid from '@material-ui/core/Grid';
import DateFnsUtils from '@date-io/date-fns';
import { MuiPickersUtilsProvider, KeyboardDatePicker } from '@material-ui/pickers';

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
    margin: 10,
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
}));

const Toolbar = (props) => {
  const {
    className,
    startDate,
    setStartDate,
    finishDate,
    setFinishDate,
    priceFilter,
    setPriceFilter,
    statusFilter,
    setStatusFilter,
    ...rest
  } = props;

  const classes = useStyles();

  const handleDateChange = (date) => {
    setStartDate(date);
  };
  const handleDateChangeFinish = (date) => {
    setFinishDate(date);
  };

  return (
    <div {...rest} className={clsx(classes.root, className)}>
      <Grid container spacing={4}>
        <Grid className={classes.date} item lg={3} sm={6} xl={3} xs={12} m={2}>
          <MuiPickersUtilsProvider utils={DateFnsUtils}>
            <Grid container justify="space-around">
              <KeyboardDatePicker
                  id="date-picker-dialog"
                  label={<span style={{ opacity: 0.6 }}>Start Date</span>}
                  format="MM/dd/yyyy"
                  value={startDate}
                  onChange={handleDateChange}
                  KeyboardButtonProps={{
                    'aria-label': 'change date',
                  }}
              />
            </Grid>
          </MuiPickersUtilsProvider>
        </Grid>
        <Grid className={classes.date} item lg={3} sm={6} xl={3} xs={12} m={2}>
          <MuiPickersUtilsProvider utils={DateFnsUtils}>
            <Grid container justify="space-around">
              <KeyboardDatePicker
                  id="date-picker-dialog-finish"
                  label={<span style={{ opacity: 0.6 }}>Finish Date</span>}
                  format="MM/dd/yyyy"
                  value={finishDate}
                  onChange={handleDateChangeFinish}
                  KeyboardButtonProps={{
                    'aria-label': 'change date'
                  }}
              />
            </Grid>
          </MuiPickersUtilsProvider>
        </Grid>
      </Grid>
    </div>
  );
};

Toolbar.propTypes = {
  className: PropTypes.string,
};

export default Toolbar;
