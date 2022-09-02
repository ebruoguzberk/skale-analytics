import React from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import { Card, CardContent, Grid, Typography, LinearProgress } from '@material-ui/core';
import { useCubeQuery } from '@cubejs-client/react';
import CountUp from 'react-countup';
import CircularProgress from '@material-ui/core/CircularProgress';

const useStyles = makeStyles((theme) => ({
  root: {
    height: '100%',
  },
  content: {
    alignItems: 'center',
    display: 'flex',
  },
  title: {
    fontWeight: 500,
  },
  progress: {
    marginTop: theme.spacing(3),
    height: '8px',
    borderRadius: '10px',
  },
  difference: {
    marginTop: theme.spacing(2),
    display: 'flex',
    alignItems: 'center',
  },
  differenceIcon: {
    color: theme.palette.error.dark,
  },
  differenceValue: {
    marginRight: theme.spacing(1),
  },
  green: {
    color: theme.palette.success.dark,
  },
  red: {
    color: theme.palette.error.dark,
  },
}));

const KPIChart = (props) => {
  const classes = useStyles();
  const { className, title, progress, query, difference, duration, ...rest } = props;
  const { resultSet, error, isLoading } = useCubeQuery(query);
  let differenceQuery;
  if(difference) {
     differenceQuery = {
      ...query,
      measures: [`${difference}`]
    };
  }
  else{
     differenceQuery = {
      ...query,
      timeDimensions: [],
    };
  }
  const differenceValue = useCubeQuery(differenceQuery);
  if (isLoading || differenceValue.isLoading) {
    return (
        <div style={{display: 'flex', alignItems: 'center', justifyContent: 'center'}}>
          <CircularProgress color="secondary"/>
        </div>
    );
  }

  if (error || differenceValue.error) {
    return <pre>{(error || differenceValue.error).toString()}</pre>;
  }
  if (!resultSet || !differenceValue.resultSet) {
    return null;
  }
  if (resultSet && differenceValue.resultSet) {
    let postfix = null;
    let prefix = null;
    const measureKey = resultSet.seriesNames()[0].key;
    const annotations = resultSet.tableColumns().find((tableColumn) => tableColumn.key === measureKey);
    const format = annotations.format || (annotations.meta && annotations.meta.format);
    if (format === 'percent') {
      postfix = '%';
    } else if (format === 'currency') {
      prefix = '$';
    }

    let value = null;
    let fullValue = resultSet.seriesNames().map((s) => resultSet.totalRow()[s.key])[0];
    if (difference) {
      let other_value = differenceValue.resultSet.seriesNames().map((s) =>  differenceValue.resultSet.totalRow()[s.key])[0];
      value =  ((other_value-fullValue) / other_value)*100
        // value = (differenceValue.resultSet.totalRow()[differenceQuery.measures[0]] / fullValue) * 100;
        // console.log("what is this value?",value)
    }

    return (
      <Card {...rest} className={clsx(classes.root, className)}>
        <CardContent>
          <Grid container justify="space-between">
            <Grid item>
              <Typography className={classes.title} color="textSecondary" gutterBottom variant="body2">
                {title}
              </Typography>
              <Typography variant="h4">
                {prefix}
                <CountUp end={fullValue} duration={duration} separator="," decimals={0} />
                {postfix}
              </Typography>
            </Grid>
          </Grid>
          {progress ? <LinearProgress className={classes.progress} value={fullValue} variant="determinate" /> : null}
          {difference ? (
            <div className={classes.difference}>
              <Typography className={classes.differenceValue} variant="body2">
                {value > 1 ? (
                  <span className={classes.green}>{value.toFixed(1)}%</span>
                ) : (
                  <span className={classes.red}>{value.toFixed(1)}%</span>
                )}
              </Typography>
              <Typography className={classes.caption} variant="caption">
                Since last month
              </Typography>
            </div>
          ) : null}
        </CardContent>
      </Card>
    );
  }
};

KPIChart.propTypes = {
  className: PropTypes.string,
  title: PropTypes.string,
};

export default KPIChart;
