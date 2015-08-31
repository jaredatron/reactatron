require 'stdlibjs/Array#flatten'

mergeChildren = require './mergeChildren'

module.exports = (args) ->
  props = args[0]
  children = [].slice.call(args, 1)
  if children.length != 0
    props ||= {}
    props.children = mergeChildren(props.children, children.flatten())
  props
