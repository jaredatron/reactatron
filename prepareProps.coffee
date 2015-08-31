require 'stdlibjs/Array#flatten'

mergeChildren = require './mergeChildren'

# Pick between children as args or children as prop
module.exports = (args) ->
  return if args.length == 0
  props = args[0]
  return props if args.length == 1
  if args.length == 2
    props.children = args[1]
  else
    props.children = [].slice.call(args, 1)
  props

