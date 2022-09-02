import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';

import Toolbar from '../components/Toolbar.js';
import Table from '../components/Table.js';
import TableSmall from '../components/TableSmall.js';

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(4),
  },
  content: {
    marginTop: 15,
  },
}));

const Reimbursement = () => {
  const classes = useStyles();
  const [statusFilter, setStatusFilter] = React.useState(0);
  const [startDate, setStartDate] = React.useState(new Date('2020-01-01T00:00:00'));
  const [finishDate, setFinishDate] = React.useState(new Date());
  const [priceFilter, setPriceFilter] = React.useState([0, 200]);
  const [sorting, setSorting] = React.useState(['Reimbursement.tx_timeStamp', 'desc']);
  const [page, setPage] = useState(0);

  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [sortingNodeOp, setSortingNodeOp] = React.useState(['Reimbursement.NodeOperator', 'desc']);
  const [pageOp, setPageOp] = useState(0);
  const [rowsOpPerPage, setRowsOpPerPage] = useState(10);

  const query = {
    limit: rowsPerPage,
    offset: rowsPerPage * page,
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
      {
        dimension: 'Reimbursement.tx_datetime',
        dateRange: [startDate, finishDate],
        granularity: null,
      },
    ],
    dimensions: [
      'Reimbursement.NodeOperator',
      'Reimbursement.tx_from',
      'Reimbursement.contract',
      'Reimbursement.contract_function_name',
      'Reimbursement.tx_datetime',
      'Reimbursement.tx_isError',
      'Reimbursement.tx_timeStamp',
      'Reimbursement.ethCost',
      'Reimbursement.tx_hash',
    ],
    filters: [], renewQuery: true
  };

  const query_agg = {
    limit: rowsOpPerPage,
    offset: rowsOpPerPage * pageOp,
    order: {
      [`${sortingNodeOp[0]}`]: sortingNodeOp[1],
    },
    timeDimensions: [
      {
        dimension: 'Reimbursement.tx_datetime',
        dateRange: [startDate, finishDate],
        granularity: null,
      },
    ],
    dimensions: [
      'Reimbursement.NodeOperator'
    ],
    measures: [
      "Reimbursement.ethTotal"
    ],
    filters: [], renewQuery: true
  };
  const countQuery = {
    order: {
      [`${sortingNodeOp[0]}`]: sortingNodeOp[1],
    },
    timeDimensions: [
      {
        dimension: 'Reimbursement.tx_datetime',
        dateRange: [startDate, finishDate],
        granularity: null,
      },
    ],
    measures: ['Reimbursement.count'],
    filters: [], renewQuery: true
  };

  const countNodeOpQuery = {
    order: {
      [`${sorting[0]}`]: sorting[1],
    },
    timeDimensions: [
      {
        dimension: 'Reimbursement.tx_datetime',
        dateRange: [startDate, finishDate],
        granularity: null,
      },
    ],
    measures: ['Reimbursement.operatorCount'],
    filters: [], renewQuery: true
  };

  return (

      <div className={classes.root}>

        <Toolbar
            startDate={startDate}
            setStartDate={setStartDate}
            finishDate={finishDate}
            setFinishDate={setFinishDate}
            priceFilter={priceFilter}
            setPriceFilter={setPriceFilter}
            statusFilter={statusFilter}
            setStatusFilter={setStatusFilter}
        />
        <div className={classes.content}>
          <Table
              sorting={sorting}
              setSorting={setSorting}
              query={query}
              countQuery={countQuery}
              rowsPerPage={rowsPerPage}
              setRowsPerPage={setRowsPerPage}
              page={page}
              setPage={setPage}
          />
        </div>
        <div className={classes.content}>
          <TableSmall
              sorting={sortingNodeOp}
              setSorting={setSortingNodeOp}
              query={query_agg}
              countQuery={countNodeOpQuery}
              rowsPerPage={rowsOpPerPage}
              setRowsPerPage={setRowsOpPerPage}
              page={pageOp}
              setPage={setPageOp}
          />
        </div>
      </div>
  );
};

export default Reimbursement;
