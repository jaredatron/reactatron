React = require 'react'

module.exports = (component) ->
  ->
    props = resolveProps(arguments)
    component(props)



module.exports.resolveProps = resolveProps


resolveProps = (args) ->
  props = {}
  for argument in args
    if isProps(arguments)
      mergeProps(props, argument)
    else
      addChildren(props, argument)
  props

mergeProps = (props, newProps) ->
  for p in newProps
    switch p
      when 'style'
        props.style ||= {}
        Object.assign(props.style, newProps.style)
      when 'className'
        props.className ||= ''
        props.className + ' ' + (newProps.className||'')
      else
        props[p] = newProps[p]

addChildren = (props, children) ->
  props.children ||= []
  if !isArray(props.children)
    props.children = [props.children]
  if !isArray(children)
    children = [children]
  props.children = props.children.concat(children)


isProps = (argument) ->
  !isArray(argument) && !React.isValidElement(argument)
