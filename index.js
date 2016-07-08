const path = require('path')
const childProcess = require('child_process')

const APP_ROOT = process.cwd()

const Reactatron = module.exports = {}

Reactatron.VERSION = 'love muffin'


Reactatron.PATH_TO_BABEL = path.join(APP_ROOT, 'node_modules/.bin/babel')

Reactatron.BABEL_ARGS =  [
  '--no-babelrc',
  // '--copy-files',
  '--presets', 'babel-preset-react,babel-preset-es2015',
  // '--only', 'src/server/index.js,src/client/index.js',
  '-d', 'dist/', 'src/'
]

Reactatron.compile = (callback) => {
  exec(Reactatron.PATH_TO_BABEL, Reactatron.BABEL_ARGS, callback)
}

Reactatron.watch = () => {
  exec(Reactatron.PATH_TO_BABEL, ['--watch'].concat(Reactatron.BABEL_ARGS))
}

Reactatron.server = () => {
  const Server = require(APP_ROOT+'/dist/server').default
  Server.start()

  // console.log('http://localhost:'+Server.get('port'))

  // if production
    // just exec APP_ROOT/dist/server

  // if development
    // start an http server that
    //   - watches babel files
    //   - proxies requests to the client app server process (sockets?)
    // start watching and restart the app server if server.js ever changes
    // proxy requests to external node server process
}

Reactatron.cli = () => {
  const command = process.argv[2] || ''
  if (command === 'compile') return Reactatron.compile()
  if (command === 'watch')   return Reactatron.watch()
  if (command === 'server')  return Reactatron.server()
  console.error('unknown command '+JSON.stringify(command))
}

const exec = (cmd, args, callback) => {
  console.log('EXEC', cmd, args)
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (callback) return callback(error, stdout, stderr)
    if (error) throw error
    console.log(stdout)
  })
}
