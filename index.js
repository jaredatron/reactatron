'use strict'

const fs = require('fs')
const path = require('path')
const childProcess = require('child_process')

const APP_ROOT = process.cwd()

const Reactatron = module.exports = {}

Reactatron.VERSION = 'love muffin'

Reactatron.root     = APP_ROOT
Reactatron.srcDir   = 'src'
Reactatron.distDir  = 'dist'

Reactatron.publicPath     = APP_ROOT+'/public'
Reactatron.serverSrcPath  = APP_ROOT+'/src/server.js'
Reactatron.clientSrcPath  = APP_ROOT+'/src/client.js'
Reactatron.styleSrcPath   = APP_ROOT+'/src/style.sass'

Reactatron.serverDistPath = APP_ROOT+'/server.js'
Reactatron.clientDistPath = APP_ROOT+'/public/client.js'
Reactatron.styleDistPath  = APP_ROOT+'/public/style.css'

Reactatron.compile = (callback) => {
  let serverDone = false
  let webpackDone = false

  Reactatron.babel.transformFile(Reactatron.serverSrcPath, {
    presets: ["react", "es2015"],
  }, (error, result) => {
    if (error) throw error
    console.log('writing', Reactatron.serverDistPath)
    fs.writeFile(Reactatron.serverDistPath, result.code)
    serverDone = true
    if (webpackDone && callback) callback()
  })

  // returns a Compiler instance
  const webpackConfig = Reactatron.webpackConfig || require('./default.webpack.config')(Reactatron)
  Reactatron.webpack(webpackConfig, (err, stats) => {
    for (var asset in stats.compilation.assets){
      console.log('writing', stats.compilation.assets[asset].existsAt)
    }
    webpackDone = true
    if (serverDone && callback) callback()
  });
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
  response.sendFile(Reactatron.publicPath + '/index.html');
}

