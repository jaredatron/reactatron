import path from 'path'
import childProcess from 'child_process'

const Reactatron  = {}

Reactatron.PATH_TO_BABEL = path.join(process.cwd(), 'node_modules/.bin/babel')

Reactatron.VERSION = '0.0.4'

Reactatron.BABEL_ARGS =  [
  '--no-babelrc',
  '--copy-files',
  ['--presets', 'babel-preset-react,babel-preset-es2015'],
  '--only', 'src/server.js,src/client.js',
  '-d', 'dist/', 'src/'
]

Reactatron.compile = (callback) => {
  console.log(require.main.paths)
  exec(Reactatron.PATH_TO_BABEL, Reactatron.BABEL_ARGS, callback)
}

Reactatron.watch = () => {
  exec(Reactatron.PATH_TO_BABEL, ['--watch'].concat(Reactatron.BABEL_ARGS))
}

const exec = (cmd, args, callback) => {
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (callback) return callback(error, stdout, stderr)
    if (error) throw error
    console.log(stdout)
  })
}

export default Reactatron
