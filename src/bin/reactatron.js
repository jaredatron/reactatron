#!/usr/bin/env node

import Reactatron from '..'
import path from 'path'
import childProcess from 'child_process'

console.log('Reactatron', Reactatron)


// babel -d dist/ src/
// console.log('???', process.argv)
console.log('???', require.main)
console.log('CWD', process.cwd())

// const PATH_TO_BABEL = path.join(__filename, '../../../node_modules/.bin/babel')
const PATH_TO_BABEL = path.join(process.cwd(), 'node_modules/.bin/babel')


const exec = (cmd, args) => {
  console.log('EXEC', cmd, args)
  childProcess.execFile(cmd, args, (error, stdout, stderr) => {
    if (error) {
      throw error;
    }
    console.log(stdout);
  });
}

if (process.argv[2] === 'compile'){

  exec('echo', ['fuck']);

  exec(PATH_TO_BABEL, [
    '--no-babelrc',
    '--presets', 'babel-preset-react', 'babel-preset-es2015',
    '-d', 'dist/', 'src/'
  ])

}
