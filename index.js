'use strict'

const path = require('path')
const childProcess = require('child_process')

const APP_ROOT = process.cwd()

const Reactatron = module.exports = {}

Reactatron.VERSION = 'love muffin'

Reactatron.APP_ROOT      = APP_ROOT
Reactatron.srcDir        = 'src'
Reactatron.clientSrcDir  = Reactatron.srcDir+'/client'
Reactatron.serverSrcDir  = Reactatron.srcDir+'/server'
Reactatron.distDir       = 'dist'
Reactatron.clientDistDir = Reactatron.distDir+'/client'
Reactatron.serverDistDir = Reactatron.distDir+'/server'
Reactatron.publicDir     = Reactatron.clientDistDir
Reactatron.serverPath    = Reactatron.serverDistDir

Reactatron.babelPath = APP_ROOT+'/node_modules/.bin/babel'
Reactatron.webpackPath = APP_ROOT+'/node_modules/.bin/webpack'

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
  console.log('EXEC', cmd, args)
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (callback) return callback(error, stdout, stderr)
    if (error) throw error
    console.log(stdout)
  })
}
