'use strict'

const path = require('path')
const childProcess = require('child_process')

const APP_ROOT = process.cwd()

const Reactatron = module.exports = {}

Reactatron.VERSION = 'love muffin'

Reactatron.APP_ROOT = APP_ROOT
Reactatron.srcDir   = 'src'
Reactatron.distDir  = 'dist'

Reactatron.publicDir      = APP_ROOT+'/public'
Reactatron.serverSrcPath  = APP_ROOT+'/src/server.js'
Reactatron.clientSrcPath  = APP_ROOT+'/src/client.js'
Reactatron.styleSrcPath   = APP_ROOT+'/src/style.sass'

Reactatron.serverDistPath = APP_ROOT+'/server.js'
Reactatron.clientDistPath = APP_ROOT+'/public/client.js'
Reactatron.styleDistPath  = APP_ROOT+'/public/style.css'

Reactatron.compile = (callback) => {
  console.log('compiling')
  exec(Reactatron.babelPath, [])
}

Reactatron.watch = () => {
  exec(Reactatron.babelPath, ['--watch'])
}

Reactatron.server = require('./server')

Reactatron.cli = () => {
  const command = process.argv[2] || ''
  if (command === 'info')    return console.log(Reactatron)
  if (command === 'compile') return Reactatron.compile()
  if (command === 'watch')   return Reactatron.watch()
  if (command === 'server')  return Reactatron.server()
  console.error('unknown command '+JSON.stringify(command))
}

Reactatron.middleware = (request, response) => {
  response.sendFile(Reactatron.publicDir + '/index.html');
}

const exec = (cmd, args, callback) => {
  cmd = APP_ROOT+'/node_modules/.bin/'+cmd
  console.log('EXEC', cmd, args)
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (callback) return callback(error, stdout, stderr)
    if (error) throw error
    console.log(stdout)
  })
}
