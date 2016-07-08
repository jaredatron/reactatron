'use strict'

const path = require('path')
const childProcess = require('child_process')

const APP_ROOT = process.cwd()

const Reactatron = module.exports = {}

Reactatron.VERSION = 'love muffin'

Reactatron.srcDir     = path.join(APP_ROOT, 'src')
Reactatron.clientSrcDir = Reactatron.srcDir+'/client'
Reactatron.serverSrcDir = Reactatron.srcDir+'/server'
Reactatron.distDir    = path.join(APP_ROOT, 'dist')
Reactatron.publicDir  = path.join(APP_ROOT, 'dist/client')
Reactatron.serverPath = path.join(APP_ROOT, 'dist/server')

Reactatron.PATH_TO_BABEL = path.join(APP_ROOT, 'node_modules/.bin/babel')

// TODO move to .bablerc
Reactatron.BABEL_ARGS =  [
  '--no-babelrc',
  '--copy-files',
  '--presets', 'babel-preset-react,babel-preset-es2015',
  // '--only', 'src/server/index.js,src/client/index.js',
  '-d', Reactatron.distDir, Reactatron.srcDir
]

Reactatron.compile = (callback) => {
  console.log('compiling')
  exec(Reactatron.PATH_TO_BABEL, Reactatron.BABEL_ARGS, callback)
}

Reactatron.watch = () => {
  exec(Reactatron.PATH_TO_BABEL, ['--watch'].concat(Reactatron.BABEL_ARGS))
}

Reactatron.server = require('./server')

Reactatron.cli = () => {
  const command = process.argv[2] || ''
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
