#!/usr/bin/env node

import path from 'path'
require.main.paths.push(path.join(process.cwd(), 'node_modules'))

import Reactatron from '..'
import Server from '../server'

// const PATH_TO_BABEL = path.join(__filename, '../../../node_modules/.bin/babel')
const PATH_TO_BABEL = path.join(process.cwd(), 'node_modules/.bin/babel')

if (process.argv[2] === 'compile'){
  Reactatron.compile()
}

if (process.argv[2] === 'watch'){
  Reactatron.watch()
}

if (process.argv[2] === 'server'){
  Server.start(()=>{
    console.log('http://localhost:'+Server.get('port'))
  })
}
