require 'stdlibjs/Number#times'
{span} = require './DOM'

module.exports = (n=1) ->
  string = ''
  string += String.fromCharCode(160) for [1..n]
  span({}, string)
