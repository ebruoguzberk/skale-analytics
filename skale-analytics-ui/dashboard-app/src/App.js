import React from 'react';
import { makeStyles, ThemeProvider } from '@material-ui/core/styles';
import cubejs from '@cubejs-client/core';
import { CubeProvider } from '@cubejs-client/react';
import theme from './theme';
import 'typeface-roboto';
import { Main } from './layouts';
import palette from './theme/palette';

const CUBEJS_TOKEN ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1Ijp7fSwiaWF0IjoxNjA1NDg0MzQyLCJleHAiOjE2MDgwNzYzNDJ9.XdC3kS1QbmV8uYaazky7Vb9jhJe0BcySRdxxtDS2NFA"
const cubejsApi = cubejs(CUBEJS_TOKEN, {
  apiUrl: `https://skale-cube.skalelabs.com/cubejs-api/v1`,
});

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    margin: '-8px',
    backgroundColor: palette.primary.light,
  },
}));

const AppLayout = ({ children }) => {
  const classes = useStyles();
  return (
    <ThemeProvider theme={theme}>
      <Main>
        <div className={classes.root}>
          <div>{children}</div>
        </div>
      </Main>
    </ThemeProvider>
  );
};

const App = ({ children }) => (
  <CubeProvider cubejsApi={cubejsApi}>
    <AppLayout>{children}</AppLayout>
  </CubeProvider>
);

export default App;
