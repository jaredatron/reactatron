isArray = require 'stdlibjs/isArray'
toArray = require 'stdlibjs/toArray'

module.exports = (left, right) ->
  children = toArray(left).concat(toArray(right))
  switch children.length
    when 1
      children[0]
    when 0
      undefined
    else
      children
