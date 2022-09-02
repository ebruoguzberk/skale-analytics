import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';
import Delegator from "../components/Delegator";
import DelegatorSearch from "../components/DelegatorSearch";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
  },
  content: {
    marginTop: 15,
  },
}));

const DataTablePage = () => {
  const classes = useStyles();
  const [sorting, setSorting] = React.useState(['Rewards.address', 'desc']);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);

  const query = {
    limit: rowsPerPage,
    offset: rowsPerPage * page,
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [],
    measures: [
      "Rewards.unclaimed",
      "Rewards.to_date",
      "Rewards.claimed"
    ],
    dimensions: [
      "Rewards.address",
      "Rewards.type",
      "Rewards.val_id"
    ],
    filters: [],
    renewQuery: true
  };

  const count = {
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
    ],
    measures: ['Rewards.count'],
    filters: [], renewQuery: true
  };

  return (
      <div className={classes.root}>
        <div className={classes.content}>
          <DelegatorSearch/>
          <Delegator
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

export default DataTablePage;
