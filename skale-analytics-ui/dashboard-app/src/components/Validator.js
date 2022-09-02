import React from 'react';
import { useHistory } from 'react-router-dom';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import PerfectScrollbar from 'react-perfect-scrollbar';
import { makeStyles } from '@material-ui/styles';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import OpenInNewIcon from '@material-ui/icons/OpenInNew';
import { useCubeQuery } from '@cubejs-client/react';
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
import palette from "../theme/palette";
import CircularProgress from "@material-ui/core/CircularProgress";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: 0
  },
  content: {
    padding: 0,
    overflowX: 'scroll'
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
  header: {
    color: palette.text.lightBlue,
    fontSize: 12,
    '&:hover': {
      color: `${palette.primary.actionHeader}`,
      cursor: `pointer`,
    },
  },
  hoverable: {
    '&:hover': {
      color: `${palette.primary.actionHeader}`,
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
      text: 'id',
      value: 'Validator.id',
    },
    {
      text: 'Name',
      value: 'Validator.name',
    },
    {
      text: 'Staked',
      value: 'Validator.Total_Staked',
    },
    {
      text: 'Fee',
      value: 'Validator.validator_fee',
    },
    {
      text: 'MDR',
      value: 'Validator.minimum_delegation',
    },
    {
      text: 'Active Nodes',
      value: 'Validator.active_nodes_in_network',
    },
    {
      text: 'Rewards to Date',
      value: 'Validator.received_fee',
    },
    {
      text: 'Staking next epoch',
      value: 'Validator.Total_Amount_Delegated_Next_Epoch',
    },
    {
      text: 'Stake for next node',
      value: 'Validator.del_needed_for_next_node',
    },
    {
      text: 'Pending Amount',
      value: 'Validator.pending_amount',
    }
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

    let validator = load.resultSet.tablePivot();

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
                <TableHead className={classes.root}>
                  <TableRow>
                    {tableHeaders.map((item) => (
                      <TableCell
                        key={item.value + Math.random()}
                        className={classes.header}
                        onClick={() => {
                          handleSetSorting(`${item.value}`);
                        }}
                      >
                        <span>{item.text}</span>
                        <Typography className={classes.arrow} variant="body2" component="span">
                          {sorting[0] === item.value ? (
                            sorting[1] === 'desc' ? (
                              <KeyboardArrowUpIcon />
                            ) : (
                              <KeyboardArrowDownIcon />
                            )
                          ) : null}
                        </Typography>
                      </TableCell>
                    ))}
                  </TableRow>
                </TableHead>
                <TableBody>
                  {validator.map((obj) => (
                    <TableRow
                      className={classes.tableRow}
                      hover
                      key={obj['Validator.id']}
                    >
                      <TableCell>{obj['Validator.id']}</TableCell>
                      <TableCell
                        className={classes.hoverable}
                        onClick={() => handleClick(`/validator/${obj['Validator.id']}`)}>
                        {obj['Validator.name']}
                        &nbsp;

                        <Typography noWrap className={classes.arrow} variant="body2" component="span">
                          <OpenInNewIcon fontSize="small" />
                        </Typography>
                      </TableCell>
                      <TableCell><Typography noWrap>{Math.ceil(obj['Validator.Total_Staked']).toLocaleString()} SKL</Typography></TableCell>
                      <TableCell>{obj['Validator.validator_fee']}%</TableCell>
                      <TableCell>{Math.ceil(obj['Validator.minimum_delegation']).toLocaleString() || 0} SKL </TableCell>
                      <TableCell>{obj['Validator.active_nodes_in_network']}</TableCell>
                      <TableCell>{Math.ceil(obj['Validator.received_fee']).toLocaleString() || 0} SKL</TableCell>
                      <TableCell>{Math.ceil(obj['Validator.Total_Amount_Delegated_Next_Epoch']).toLocaleString() || 0 } SKL</TableCell>
                      <TableCell>{Math.ceil(obj['Validator.del_needed_for_next_node']).toLocaleString() || 0} SKL</TableCell>
                      <TableCell>{Math.ceil(obj['Validator.pending_amount']).toLocaleString() || 0} SKL</TableCell>
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
              count={parseInt(count.resultSet.tablePivot()[0]['Validator.Validator_count'])}
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
