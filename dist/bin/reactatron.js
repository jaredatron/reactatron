#!/usr/bin/env node
'use strict';

var _ = require('..');

var _2 = _interopRequireDefault(_);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _child_process = require('child_process');

var _child_process2 = _interopRequireDefault(_child_process);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

console.log('Reactatron', _2.default);

// babel -d dist/ src/
// console.log('???', process.argv)
console.log('???', require.main);
console.log('CWD', process.cwd());

const PATH_TO_BABEL = _path2.default.join(__filename, '../../../node_modules/.bin/babel');

const exec = (cmd, args) => {
  console.log('EXEC', cmd, args);
  _child_process2.default.execFile(cmd, args, (error, stdout, stderr) => {
    if (error) {
      throw error;
    }
    console.log(stdout);
  });
};

if (process.argv[2] === 'compile') {

  exec('echo', ['fuck']);

  exec(PATH_TO_BABEL, ['--no-babelrc', '--presets', 'babel-preset-react', 'babel-preset-es2015-node', '-d', 'dist/', 'src/']);
}