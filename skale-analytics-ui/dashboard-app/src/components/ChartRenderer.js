import React from 'react';
import PropTypes from 'prop-types';
import { useCubeQuery } from '@cubejs-client/react';
import CircularProgress from '@material-ui/core/CircularProgress';
import { Line, Bar, Doughnut } from 'react-chartjs-2';
import Typography from '@material-ui/core/Typography';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import palette from '../theme/palette';
import moment from 'moment';
import { BarOptions } from '../helpers/BarOptions.js';

const COLORS_SERIES = [
  palette.secondary.secondary4,
  palette.secondary.main,
  palette.secondary.light,
  palette.secondary.lighten,
  palette.secondary.secondary5,
  palette.secondary.secondary6,
  palette.secondary.secondary7,
  palette.secondary.secondary8,
  palette.secondary.secondary9,
  palette.secondary.secondary10,
  palette.secondary.secondary11,
  palette.secondary.secondary12,
  palette.secondary.secondary13,
  palette.secondary.secondary14,
  palette.secondary.secondary15,
  palette.secondary.secondary16,
  palette.secondary.secondary17,
  palette.secondary.secondary18,
  palette.secondary.secondary19];
const COLORS_SERIES_BORDER = [palette.chart.borderOne, palette.primary.light, palette.secondary.light];

const TypeToChartComponent = {
  line: ({ resultSet }) => {
    const data = {
      labels: resultSet.categories().map((c) => c.category),
      datasets: resultSet.series().map((s, index) => ({
        label: s.title,
        data: s.series.map((r) => r.value),
        borderColor: COLORS_SERIES_BORDER[index],
        fill: false,
      })),
    };
    const options = {};
    return <Line data={data} options={options} />;
  },
  bar: ({ resultSet }) => {
    const data = {
      labels: resultSet.categories().map((c) => moment(c.category).format('MM/YYYY')),
      datasets: resultSet.series().map((s, index) => ({
        label: s.title,
        data: s.series.map((r) => r.value),
        backgroundColor: COLORS_SERIES[index],
        borderColor: COLORS_SERIES_BORDER[index],
        fill: false,
      })),
    };
    return <Bar data={data} options={BarOptions} />;
  },
  area: ({ resultSet }) => {
    const data = {
      labels: resultSet.categories().map((c) => moment(c.category).format('MM/YYYY')),
      datasets: resultSet.series().map((s, index) => ({
        label: s.title,
        data: s.series.map((r) => r.value),
        backgroundColor: COLORS_SERIES[index],
        borderColor: COLORS_SERIES_BORDER[index],
      })),
    };
    const options = {
      scales: {
        yAxes: [{
          stacked: true,
          ticks: {
            beginAtZero: false,
            padding: 10
          },
          gridLines: {
            drawTicks: false,
            display: true,
            color: '#414142',
            lineWidth: 1
          }
        }],
        xAxes: [{
          ticks: {
            beginAtZero: false,
            padding: 10
          },
          gridLines: {
            drawTicks: false,
            display: true,
            color: '#414142',
            lineWidth: 1
          }
        }]
      }
    };
    return <Line data={data} options={options} />;
  },
  pie: ({ resultSet }) => {
    const data = {
      labels: resultSet.categories().map((c) => c.category),
      datasets: resultSet.series().map((s) => ({
        label: s.title,
        data: s.series.map((r) => r.value),
        backgroundColor: COLORS_SERIES,
        hoverBackgroundColor: COLORS_SERIES,
      })),
    };
    const options = {};
    return <Doughnut data={data} options={options} />;
  },
  number: ({ resultSet }) => (
    <Typography
      variant="h4"
      style={{
        textAlign: 'center',
      }}
    >
      {resultSet.seriesNames().map((s) => resultSet.totalRow()[s.key])}
    </Typography>
  ),
  value: ({ resultSet }) => (
      <div>
        {
          resultSet.tablePivot()[0] ? (
              resultSet.tablePivot().map((row, index) => (
                  <div key={index}>
                    {resultSet.tableColumns().map((c) => (
                        <Typography variant="body2" key={c.key} >{row[c.key]}</Typography>
                    ))}
                  </div>
              ))
        ):""}</div>
  ),

  table: ({ resultSet }) => (
    <Table aria-label="simple table">
      <TableHead>
        <TableRow>
          {resultSet.tableColumns().map((c) => (
            <TableCell key={c.key}>{c.title}</TableCell>
          ))}
        </TableRow>
      </TableHead>
      <TableBody>
        {resultSet.tablePivot().map((row, index) => (
          <TableRow key={index}>
            {resultSet.tableColumns().map((c) => (
              <TableCell key={c.key}>{row[c.key]}</TableCell>
            ))}
          </TableRow>
        ))}
      </TableBody>
    </Table>
  ),
  table_opposite_xy: ({ resultSet }) => (
      <Table aria-label="simple table">

            {resultSet.tableColumns().map((c) => (
                <TableRow key={c.key}>
                  <TableCell key={c.key}>{c.title}</TableCell>
                  {resultSet.tablePivot().map((row) => (
                      <TableCell key={c.key}>
                        {row[c.key]}
                      </TableCell>
                  ))}
                </TableRow>
            ))}
      </Table>
  ),
};
const TypeToMemoChartComponent = Object.keys(TypeToChartComponent)
  .map((key) => ({
    [key]: React.memo(TypeToChartComponent[key]),
  }))
  .reduce((a, b) => ({ ...a, ...b }));

const renderChart = (Component) => ({ resultSet, error, ...props }) =>
  (resultSet && <Component resultSet={resultSet} {...props} />) ||
  (error && error.toString()) || <CircularProgress color="secondary" />;

const ChartRenderer = ({ vizState = {} }) => {
  const { query, chartType, ...options } = vizState;
  const component = TypeToMemoChartComponent[chartType];
  const renderProps = useCubeQuery(query);
  return component && renderChart(component)({ ...options, ...renderProps });
};

ChartRenderer.propTypes = {
  vizState: PropTypes.object,
  cubejsApi: PropTypes.object,
};
export default ChartRenderer;
