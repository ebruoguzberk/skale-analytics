import React from 'react';
import { useParams } from 'react-router-dom';
import { makeStyles } from '@material-ui/styles';
import { Grid } from '@material-ui/core';
import TableChart from "../components/TableChart";
import palette from "../theme/palette";
import MainnetStatusSearch from "../components/MainnetStatusSearch";
import MainnetStatusTopBar from "../components/MainnetStatusTopBar";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
    backgroundColor: palette.primary.medium,
  }
}));

const MainnetStatusValidatorPage = (props) => {

  const classes = useStyles();
  let {id} = useParams();

  const status = {
    dimensions: [
      "NodeHealth.node_id",
      "NodeHealth.Name",
      "NodeHealth.IsNodeActive",
      "NodeHealth.BalanceCheck",
      "NodeHealth.SRW_balance",
      "NodeHealth.ContainerStatuses",
      "NodeHealth.ComponentVersions",
      "NodeHealth.SgxStatus",
      "NodeHealth.SGXVersion",
      "NodeHealth.Hardware",
      "NodeHealth.BTRFS",
      "NodeHealth.ValNodes",
      "NodeHealth.PublicIP",
      "NodeHealth.Endpoint",
      "NodeHealth.Address",
      "NodeHealth.TrustedEndpoint",
      "NodeHealth.FilebeatLogs",
    ],
    timeDimensions: [],
    order: {},
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
    ],
    renewQuery: true
  }

  const hardware = {
    dimensions: [
      "NodeHealth.node_id",
      "NodeHealth.Name",
      "NodeHealth.CoreCheck",
      "NodeHealth.Cores",
      "NodeHealth.MemoryCheck",
      "NodeHealth.Memory",
      "NodeHealth.StorageCheck",
      "NodeHealth.Storage",
      "NodeHealth.SwapCheck",
      "NodeHealth.Swap"
    ],
    timeDimensions: [],
    order: {},
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
    ],
    renewQuery: true
  }

  const containers_versions = {
    dimensions: [
      "NodeHealth.node_id",
      "NodeHealth.Name",
      "NodeHealth.container_admin",
      "NodeHealth.container_API",
      "NodeHealth.nginx",
      "NodeHealth.container_TransactionManager",
      "NodeHealth.container_Mysql",
      "NodeHealth.container_WatchDog",
      "NodeHealth.container_Bounty",
      "NodeHealth.container_Filebeat",
      "NodeHealth.container_Configs",
      "NodeHealth.container_CLI",
      "NodeHealth.container_sChain",
      "NodeHealth.container_Lvmpy"
    ],
    timeDimensions: [],
    order: {},
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
    ],
    renewQuery: true
  }

  const query = {
    dimensions: [
      "Validator.id",
      "Validator.name",
      "Validator.address",
      "ValidatorHealth.status",
    ],
    filters: [
      {
        dimension: 'Validator.id',
        operator: 'equals',
        values: [`${id}`],
      },
    ], renewQuery: true
  };

  const schains = {
    dimensions: [
      "ChainHealth.node_id",
      "ChainHealth.schain_name",
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
    filters: [
      {
        dimension: 'Node.validator_id',
        operator: 'equals',
        values: [`${id}`],
      },
    ], renewQuery: true
  };

  return (

        <div className={classes.root}>
          <MainnetStatusSearch/>
          <Grid item>
              <MainnetStatusTopBar query={query}/>
          </Grid>

          <Grid container spacing={4}>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={hardware} title={"Validator Hardware"} />
            </Grid>
          </Grid>


          <Grid container spacing={4}>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={status} title={"Validator Node Health Checks"} />
            </Grid>
          </Grid>

          <Grid container spacing={4}>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={schains} title={"Nodes that supports Active Schains"} />
            </Grid>
          </Grid>


          <Grid container spacing={4}>
            <Grid item lg={12} md={12} xl={12} xs={12}>
              <TableChart query={containers_versions} title={"Container versions"} />
            </Grid>
          </Grid>

        </div>
    );
};

export default MainnetStatusValidatorPage;
