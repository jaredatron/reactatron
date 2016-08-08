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
    serverProcess = childProcess.execFile('node', [Reactatron.serverDistPath])

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


  const serverWatcher = watcher(Reactatron.srcDir+'/server*')

  const serverSourceChange = (path) => {
    console.log('server source change', path)
    restartServer()
  }

  serverWatcher
    .on('add',    serverSourceChange)
    .on('unlink', serverSourceChange)
    .on('change', serverSourceChange)


  const clientWatcher = watcher(Reactatron.srcDir+'/client*')

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

