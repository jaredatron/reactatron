'use strict'

const Reactatron = require('.')
const chokidar = require('chokidar')
const childProcess = require('child_process')

module.exports = () => {
  let serverProcess

  const restartServer = () => {
    if (serverProcess){
      console.log('killing server')
      serverProcess.killing = true
      serverProcess.kill()
    }
    Reactatron.compile(startServer)
  }

  const startServer = () => {
    console.log('starting server')
    serverProcess = childProcess.execFile('node', [Reactatron.serverPath])

    serverProcess.stdout.on('data', (data) => {
      console.log(data)
    })

    serverProcess.stderr.on('data', (data) => {
      console.error(data)
    })

    serverProcess.on('close', (code) => {
      if (serverProcess.killing) return
      console.log(`server exited with code ${code}`)
      restartServer()
    })
  }

  restartServer()


  const serverWatcher = watcher(Reactatron.serverSrcDir)

  const serverSourceChange = (path) => {
    console.log('server source change', path)
    restartServer()
  }

  serverWatcher
    .on('add',    serverSourceChange)
    .on('unlink', serverSourceChange)
    .on('change', serverSourceChange)


  const clientWatcher = watcher(Reactatron.clientSrcDir)

  const clientSourceChange = (path) => {
    console.log('client source change', path)
    Reactatron.compile()
  }

  clientWatcher
    .on('add',    clientSourceChange)
    .on('unlink', clientSourceChange)
    .on('change', clientSourceChange)
}

const watcher = (path) => {
  return chokidar.watch(path, {
    ignored: /[\/\\]\./,
    ignoreInitial: true,
    persistent: true
  })
}

// const path = require('path')
// const express = require('express')
// const bodyParser = require('body-parser')
// const Reactatron = require('.')

// const Server = express()

// const srcPath   = path.join(process.cwd(), 'src')
// const publicDir = path.join(process.cwd(), 'dist/client')
// const cachePath = path.join(process.cwd(), 'temp/cache')

// console.log('publicDir', publicDir)

// Server.set('port', process.env.PORT || '3000')


// if (process.env.NODE_ENV === "development"){
//   const babel = require('babel-core')
//   Server.use((req, res, next) => {
//     console.log('recompiling')
//     Reactatron.compile(next)
//   })
// }


// Server.use(bodyParser.json())
// Server.use(express.static(publicDir))

// Server.get('/*', (request, response) => {
//   response.sendFile(publicDir + '/index.html')
// })

// Server.start = (callback) => {
//   Server.listen(Server.get('port'), () => {
//     if (callback) callback(Server)
//   })
// }

// module.exports = Server


//   (Reactatron)
//   // Reactatron.compile()
//   // const Server = require(APP_ROOT+'/dist/server').default
//   // console.log('http://localhost:'+Server.get('port'))
//   // Server.start()

//   // if production
//     // just exec APP_ROOT/dist/server

//   // if development
//     // start an http server that
//     //   - watches babel files
//     //   - proxies requests to the client app server process (sockets?)
//     // start watching and restart the app server if server.js ever changes
//     // proxy requests to external node server process
// }
