import React, { useState } from 'react';
import { makeStyles } from '@material-ui/styles';
import ValidatorDiffTable from '../components/ValidatorDiffTable.js';
import NodeStatsDiff from '../components/NodeStatsDiff.js';

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
  const [sorting, setSorting] = React.useState(['Validator.id', 'asc']);
  const [nodeSorting, setNodeSorting] = React.useState(['Node.id', 'asc']);
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
    measures:[
      "Validator.Total_Staked",
      "Validator.Total_Amount_Delegated_Next_Epoch",
      "Validator.del_needed_for_next_node",
      "Validator.del_needed_for_next_node_with_proposed",
      "Validator.active_nodes_in_network",
      "Validator.NodeDanger",
      "Validator.activate_undelegation_probability_by_next_epoch"
    ],
    dimensions: [
      "Validator.id",
      "Validator.name"
    ],
    filters: [], renewQuery: true
  };

  const query_node = {
    limit: rowsPerPage,
    offset: rowsPerPage * page,
    order: {
      [`${nodeSorting[0]}`]: nodeSorting[1],
    },
    dimensions: [
      "Node.name",
      "Node.id",
      "Node.validator_id",
      "Node.validator_name",
      "Node.last_bounty_call",
      "Node.called_getBounty_this_epoch",
      "Node.balance"
    ],
    timeDimensions: [],
    filters: [
      {
        dimension: "Node.status",
        operator: "notContains",
        values: [
          "inactive"
        ]
      }
    ]
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

  const count_node = {
    order: {
      [`${nodeSorting[0]}`]: nodeSorting[1],
    },
    timeDimensions: [
    ],
    measures: ['Node.count'],
    filters:[
    {
      dimension: "Node.status",
      operator: "notContains",
      values: [
        "inactive"
      ]
    }
  ], renewQuery: true
  };

  return (
      <div className={classes.root}>
        <div className={classes.content}>
          <ValidatorDiffTable
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
          <div className={classes.content}>
          <NodeStatsDiff
              sorting={nodeSorting}
              setSorting={setNodeSorting}
              query={query_node}
              countQuery={count_node}
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
