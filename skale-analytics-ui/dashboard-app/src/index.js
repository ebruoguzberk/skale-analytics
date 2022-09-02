import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import * as serviceWorker from './serviceWorker';
import { HashRouter as Router, Route, Switch, Redirect } from 'react-router-dom';
import DashboardPage from './pages/DashboardPage';
import ValidatorTablePage from './pages/ValidatorTablePage';
import ValidatorPage from './pages/ValidatorPage';
import Reimbursement from './pages/Reimbursement';
import ValidatorDiff from './pages/ValidatorDiff';
import DelegatorTablePage from "./pages/DelegatorTablePage";
import DelegatorPage from "./pages/DelegatorPage";
import MainnetStatusTablePage from "./pages/MainnetStatusTablePage";
import MainnetStatusValidatorPage from "./pages/MainnetStatusValidatorPage";
import ChainHealthPage from "./pages/ChainHealthPage";
import ChainTablePage from "./pages/ChainTablePage";

ReactDOM.render(
    <Router>
      <App>
        <Switch>
          <Redirect exact from="/" to="/dashboard" />
          <Route key="index" exact path="/dashboard" component={DashboardPage} />
          <Route key="index" exact path="/reimbursement" component={Reimbursement} />
          <Route key="index" exact path="/validatordiff" component={ValidatorDiff} />
          <Route key="table" path="/validators" component={ValidatorTablePage} />
          <Route key="index" path="/validator/:id" component={ValidatorPage} />
          // deprecated : <Route key="index" path="/mainnetstatus/:id" component={MainnetStatusValidatorPage} />
          // deprecated : <Route key="table" path="/mainnetstatus" component={MainnetStatusTablePage} />
          <Route key="index" path="/tokenholder/:address" component={DelegatorPage} />
          <Route key="table" path="/tokenholders" component={DelegatorTablePage} />
          <Route key="index" path="/chain/:id" component={ChainHealthPage} />
          <Route key="table" path="/chains" component={ChainTablePage} />
          <Redirect to="/dashboard" />
        </Switch>
      </App>
    </Router>,
  document.getElementById('root')
); // If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA

serviceWorker.unregister();
