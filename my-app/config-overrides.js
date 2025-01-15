const path = require('path');

module.exports = function override(config, env) {
  config.resolve.alias = {
    ...config.resolve.alias,
    AdminPage: path.resolve(__dirname, '../admin-page/admin/src/'),
  };
  return config;
};
