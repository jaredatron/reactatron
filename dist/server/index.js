'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _bodyParser = require('body-parser');

var _bodyParser2 = _interopRequireDefault(_bodyParser);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// Reactatron.Server

const Server = (0, _express2.default)();

Server.use(_bodyParser2.default.json());
// Server.use(express.static(publicDir))

// Server.get('/*', (request, response) => {
//   response.sendFile(publicDir + '/index.html');
// });

Server.start = callback => {
  Server.listen(Server.get('port'), () => {
    callback(Server);
  });
};

exports.default = Server;