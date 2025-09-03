const express = require('express');
const _ = require('lodash');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  const users = [{ user: 'admin' }, { user: 'guest' }];
  res.send('Users: ' + JSON.stringify(_.map(users, 'user')));
});

app.listen(port, () => {
  console.log(`Vulnerable app listening at http://localhost:${port}`);
});
