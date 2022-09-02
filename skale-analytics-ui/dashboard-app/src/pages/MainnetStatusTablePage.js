import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';
import MainnetStatusSearch from "../components/MainnetStatusSearch";
import MainnetStatus from "../components/MainnetStatus";
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

const MainnetStatusTablePage = () => {
  const classes = useStyles();
  const [sorting, setSorting] = React.useState(['Validator.id', 'desc']);
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
      "Validator.id",
      "Validator.name",
      "Validator.address",
      "ValidatorHealth.status",
    ],
    filters: [], renewQuery: true
  };

  const count = {
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
    ],
    measures: ['Validator.Validator_count'],
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
      title: 'Nodes Not Ready',
      query: {
        dimensions: [],
        timeDimensions: [],
        order: {},
        filters: [
          {
            dimension: "NodeHealth.full_health",
            operator: "equals",
            values: [
              "Not Ready"
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
      title: 'Active Nodes',
      query: {
        dimensions: [],
        timeDimensions: [],
        order: {},
        filters: [
          {
            "dimension": "NodeHealth.Status",
            "operator": "equals",
            "values": [
              "ACTIVE"
            ]
          }
        ],
        measures: [
          "NodeHealth.Node_count"
        ]
      }
      ,duration: 1.1
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

        <MainnetStatusSearch/>

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
          <Grid container spacing={4}>

            <Grid item lg={12} md={12} xl={8} xs={12}>
          <MainnetStatus
              sorting={sorting}
              setSorting={setSorting}
              query={query}
              countQuery={count}
              rowsPerPage={rowsPerPage}
              setRowsPerPage={setRowsPerPage}
              page={page}
              setPage={setPage}
          />
            </Grid>

          </Grid>
        </div>
      </div>
  );
};

export default MainnetStatusTablePage;
