// Reactatron.Server

import express from 'express'
import bodyParser from'body-parser'

const Server = express()

Server.use(bodyParser.json())
// Server.use(express.static(publicDir))

// Server.get('/*', (request, response) => {
//   response.sendFile(publicDir + '/index.html');
// });

Server.start = (callback) => {
  Server.listen(Server.get('port'), () => {
    callback(Server);
  });
};

export default Server
