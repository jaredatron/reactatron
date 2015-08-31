require 'stdlibjs/Array#flatten'

mergeChildren = require './mergeChildren'

module.exports = (args) ->
  return args[0] if args.length < 2
  props = args[0]
  children = [].slice.call(args, 1)
  if children.length != 0
    props ||= {}
    props.children = mergeChildren(props.children, children.flatten())
  props
