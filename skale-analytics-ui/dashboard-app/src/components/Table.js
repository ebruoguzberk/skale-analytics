import React from 'react';
import { useHistory } from 'react-router-dom';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import moment from 'moment';
import PerfectScrollbar from 'react-perfect-scrollbar';
import { makeStyles } from '@material-ui/styles';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import OpenInNewIcon from '@material-ui/icons/OpenInNew';
import { useCubeQuery } from '@cubejs-client/react';
import CircularProgress from '@material-ui/core/CircularProgress';
import {
  Card,
  CardActions,
  CardContent,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  TablePagination,
  Typography,
} from '@material-ui/core';

import StatusBullet from './StatusBullet';
import palette from '../theme/palette';

const useStyles = makeStyles((theme) => ({
  root: {
    padding: 0,
    overflowX: 'scroll'
  },
  content: {
    padding: 0,

  },
  head: {
    fontSize: 14
  },
  inner: {
    minWidth: 1050,
  },
  nameContainer: {
    display: 'flex',
    alignItems: 'baseline',
  },
  status: {
    marginRight: theme.spacing(2),
  },
  actions: {
    justifyContent: 'flex-end',
  },
  tableRow: {
    padding: '0 5px',
    '.MuiTableRow-root.MuiTableRow-hover&:hover': {
      backgroundColor: palette.primary.action,
    },
  },
  hoverable: {
    '&:hover': {
      color: `${palette.primary.normal}`,
      cursor: `pointer`,
    },
  },
  arrow: {
    fontSize: 10,
    position: 'absolute',
  },
}));

const TableComponent = (props) => {
  const history = useHistory();

  function handleClick(str) {
    history.push(str);
  }

  const {
    className,
    sorting,
    setSorting,
    query,
    countQuery,
    rowsPerPage,
    page,
    setRowsPerPage,
    setPage,
    ...rest
  } = props;

  const classes = useStyles();

  const tableHeaders = [
    {
      text: 'Node Operator',
      value: 'Reimbursement.NodeOperator',
    },
    {
      text: 'Contract',
      value: 'Reimbursement.contract',
    },
    {
      text: 'Contract Function',
      value: 'Reimbursement.contract_function_name',
    },
    {
      text: 'ETH Cost',
      value: 'Reimbursement.ethCost',
    },
    {
      text: 'TimeStamp',
      value: 'Reimbursement.tx_timeStamp',
    },
    {
      text: 'Hash',
      value: 'Reimbursement.tx_hash',
    },
  ];
  const load = useCubeQuery(query);
  const count = useCubeQuery(countQuery);
  if (load.isLoading || count.isLoading) {
    return (
        <div
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              minHeight: `${124 + rowsPerPage * 54}px`,
              background: '#000000',
              borderRadius: '5px',
            }}
        >
          <CircularProgress color="secondary" />
        </div>
    );
  }
  if (load.error || count.error) {
    return <pre>{load.error.toString()}</pre>;
  }
  if (!load.resultSet || !count.resultSet) {
    return null;
  }
  if (load.resultSet && count.resultSet) {
    let reimbursements = load.resultSet.tablePivot();

    const handlePageChange = (event, page) => {
      setPage(page);
    };
    const handleRowsPerPageChange = (event) => {
      setRowsPerPage(event.target.value);
    };
    const handleSetSorting = (str) => {
      setSorting([str, sorting[1] === 'desc' ? 'asc' : 'desc']);
    };

    return (
        <Card {...rest} padding={'0'} className={clsx(classes.root, className)}>
          <CardContent className={classes.content}>
            <PerfectScrollbar>
              <div className={classes.inner}>
                <Table>
                  <TableHead className={classes.head}>
                    <TableRow>
                      {tableHeaders.map((item) => (
                          <TableCell
                              key={item.value + Math.random()}
                              className={classes.hoverable}
                              onClick={() => {
                                handleSetSorting(`${item.value}`);
                              }}
                          >
                            <span>{item.text}</span>
                          </TableCell>
                      ))}
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {reimbursements.map((obj) => (
                        <TableRow
                            className={classes.tableRow}
                            hover
                            key={obj['Reimbursement.tx_hash']}>
                          <TableCell>{obj['Reimbursement.NodeOperator']}</TableCell>
                          <TableCell>{obj['Reimbursement.contract']}</TableCell>
                          <TableCell>{obj['Reimbursement.contract_function_name']}</TableCell>
                          <TableCell>{obj['Reimbursement.ethCost']}</TableCell>
                          <TableCell>{moment(obj['Reimbursement.tx_datetime']).format('DD/MM/YYYY')}</TableCell>
                          <TableCell>{obj['Reimbursement.tx_hash']}</TableCell>
                        </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </PerfectScrollbar>
          </CardContent>
          <CardActions className={classes.actions}>
            <TablePagination
                component="div"
                count={parseInt(count.resultSet.tablePivot()[0]['Reimbursement.count'])}
                onChangePage={handlePageChange}
                onChangeRowsPerPage={handleRowsPerPageChange}
                page={page}
                rowsPerPage={rowsPerPage}
                rowsPerPageOptions={[5, 10, 25, 50, 100]}
            />
          </CardActions>
        </Card>
    );
  }
};

TableComponent.propTypes = {
  className: PropTypes.string,
  query: PropTypes.object.isRequired,
};

export default TableComponent;
