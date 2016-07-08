// Reactatron.Server

import path from 'path'
import express from 'express'
import bodyParser from'body-parser'

const Server = express()
const publicDir = path.join(process.cwd(), 'dist/client')

console.log('publicDir', publicDir)

Server.set('port', process.env.PORT || '3000')

Server.use(bodyParser.json())
Server.use(express.static(publicDir))

Server.get('/*', (request, response) => {
  response.sendFile(publicDir + '/index.html');
});

Server.start = (callback) => {
  Server.listen(Server.get('port'), () => {
    if (callback) callback(Server);
  });
};

export default Server
