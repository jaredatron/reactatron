require('babel-core');
require('babel-register')({
  presets: ['babel-preset-react', 'babel-preset-es2015-node'],
});
require("babel-register")

module.exports = require('./lib')
