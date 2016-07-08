#!/usr/bin/env node

import path from 'path'
require.main.paths.push(path.join(process.cwd(), 'node_modules'))

import Reactatron from '..'
import Server from '../server'
import childProcess from 'child_process'

const exec = (cmd, args) => {
  // console.log('EXEC', cmd, args)
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (error) throw error
    console.log(stdout)
  })
}

// const PATH_TO_BABEL = path.join(__filename, '../../../node_modules/.bin/babel')
const PATH_TO_BABEL = path.join(process.cwd(), 'node_modules/.bin/babel')
const BABEL_ARGS = [
  '--no-babelrc',
  '--copy-files',
  '--presets', 'babel-preset-react,babel-preset-es2015',
  '--only', 'src/server,src/client',
  '-d', 'dist/', 'src/'
]

const BABEL_WATCH_ARGS = ['--watch'].concat(BABEL_ARGS)
if (process.argv[2] === 'compile'){
  exec(PATH_TO_BABEL, BABEL_ARGS)
}

if (process.argv[2] === 'watch'){
  exec(PATH_TO_BABEL, BABEL_WATCH_ARGS)
}

if (process.argv[2] === 'server'){
  Server.start(()=>{
    console.log('http://localhost:'+Server.get('port'))
  })
}
