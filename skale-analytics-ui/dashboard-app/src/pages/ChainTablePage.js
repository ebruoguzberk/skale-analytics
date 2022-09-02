import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';
import ChainSearch from "../components/ChainSearch";
import Chains from "../components/Chains";
import {Grid} from "@material-ui/core";
import KPIChart from "../components/KPIChart";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
  },
  content: {
    marginTop: 15,
  },
}));

const ChainTablePage = () => {
  const classes = useStyles();
  const [sorting, setSorting] = React.useState(['ChainInfo.name', 'desc']);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(50);

  const query = {
    limit: rowsPerPage,
    offset: rowsPerPage * page,
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
    ],
    dimensions: [
      "ChainInfo.name",
      "ChainInfo.Type",
      "ChainInfo.creation_type",
      "ChainInfo.owner",
      "ChainInfo.rotation_id",
      "ChainInfo.nodes"
    ],
    filters: [], renewQuery: true
  };

  const count = {
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
    ],
    measures: ['ChainInfo.TotalLiveChains'],
    filters: [], renewQuery: true
  };

  const cards = [
    {
      title: 'SKALE Chain Ready Nodes',
      query: {
      dimensions: [],
      timeDimensions: [],
      order: {},
      filters: [
        {
          dimension: "NodeHealth.full_health",
          operator: "equals",
          values: [
            "SKALE Chain Ready"
          ]
        }
      ],
      measures: [
        "NodeHealth.Node_count"
      ]

    }
      ,duration: 0.75
    },
    {
      title: 'Schains Live',
      query: {
        dimensions: [],
        timeDimensions: [],
        order: {},
        filters: [
        ],
        measures: [
          "ChainInfo.TotalLiveChains"
        ]
      }
      ,duration: 1.1
    }

  ]

  return (
      <div className={classes.root}>

        <ChainSearch/>

        <Grid container spacing={10}>
          {cards.map((item, index) => {
            return (
                <Grid key={item.title + index} item lg={2} sm={2} xl={2} xs={4}>
                  <KPIChart {...item} />
                </Grid>
            );
          })}
        </Grid>
        <div className={classes.content}>
          <Chains
              sorting={sorting}
              setSorting={setSorting}
              query={query}
              countQuery={count}
              rowsPerPage={rowsPerPage}
              setRowsPerPage={setRowsPerPage}
              page={page}
              setPage={setPage}
          />
        </div>
      </div>
  );
};

export default ChainTablePage;
