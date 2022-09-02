import React from 'react';
import { useParams } from 'react-router-dom';
import { makeStyles } from '@material-ui/styles';
import { Grid } from '@material-ui/core';
import TableChart from "../components/TableChart";
import palette from "../theme/palette";
import ChainSearch from "../components/ChainSearch";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
    backgroundColor: palette.primary.medium,
  }
}));

const ChainHealthPage = (props) => {

  const classes = useStyles();
  let {id} = useParams();


  const query = {
    dimensions: [

      "Validator.name",
      "Node.name",
      "ChainHealth.node_id",
      "ChainHealth.schain_name",
      "ChainHealth.HTTP",
      "ChainHealth.HTTPs",
      "ChainHealth.Blocks",
      "ChainHealth.data_directory",
      "ChainHealth.DKG",
      "ChainHealth.config_file",
      "ChainHealth.Volume",
      "ChainHealth.Container",
      "ChainHealth.IMA",
      "ChainHealth.Firewall",
      "ChainHealth.RPC"
    ],
    timeDimensions: [],
    order: {},
    filters: [
      {
        dimension: 'ChainHealth.schain_name',
        operator: 'equals',
        values: [`${id}`],
      },
    ],
    renewQuery: true
  }


  return (

        <div className={classes.root}>
          <ChainSearch/>
          <Grid container spacing={4}>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={query} title={"SKALE Chain supported Node List"} />
            </Grid>
          </Grid>

        </div>
    );
};

export default ChainHealthPage;
