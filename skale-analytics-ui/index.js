const CubejsServerCore = require('@cubejs-backend/server-core');
const express = require('express');
const bodyParser = require("body-parser");
const path = require("path");
const http = require("http");
const MySQLDriver = require('@cubejs-backend/mysql-driver');
require('dotenv').config()

const expressApp = express();
expressApp.use(bodyParser.json({ limit: "50mb" }));
expressApp.use(require('cors')());

const options = {
  dbType: process.env.CUBEJS_DB_TYPE,
  apiSecret: process.env.CUBEJS_API_SECRET,
  driverFactory: ({datasource}) => new MySQLDriver(
      {
        database: process.env.CUBEJS_DB_NAME,
        host: process.env.CUBEJS_DB_HOST,
        user: process.env.CUBEJS_DB_USER,
        password: process.env.CUBEJS_DB_PASS
      })
};

const core = CubejsServerCore.create(options);
core.initApp(expressApp);

const port = process.env.PORT || 4000;
const server = http.createServer({}, expressApp);

server.listen(port, () => {
  console.log(`🚀 Cube.js server is listening on ${port}`);
});
