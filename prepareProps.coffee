isArray = require 'stdlibjs/isArray'
Style = require './Style'

prepareProps = (props, children...) ->
  props = props? and Object.clone(props) or {}
  props.children = mergeChildren(props.children, children)
  props.style = new Style(props.style)
  props

shoveChildrenIntoProps = (props, children) ->
  children =
  if children? && children.length > 0
    props.children = children
  else
    delete props.children


# this might be an aweful idea :P
mergeChildren = (a, b) ->
  a = []  unless a?
  a = [a] unless isArray(a)
  a = a.concat(b) if b?
  a

module.exports = prepareProps
