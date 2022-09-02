import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';
import Validator from '../components/Validator.js';
import ValidatorSearch from "../components/ValidatorSearch";

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
  const [sorting, setSorting] = React.useState(['Validator.id', 'desc']);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);

  const query = {
    limit: rowsPerPage,
    offset: rowsPerPage * page,
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
    ],
    measures:["Validator.active_nodes_in_network",
      "Validator.received_fee",
      "Validator.Total_Staked",
      "Validator.Total_Amount_Delegated_Next_Epoch",
      "Validator.del_needed_for_next_node",
      "Validator.pending_amount"
    ],
    dimensions: [
      "Validator.id",
      "Validator.name",
      "Validator.validator_fee",
      "Validator.minimum_delegation",
      "Validator.delegated_next_epoch"
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

  return (
      <div className={classes.root}>
        <div className={classes.content}>
          <ValidatorSearch/>
          <Validator
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
