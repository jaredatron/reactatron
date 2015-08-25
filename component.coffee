React = require 'react'
BaseMixin = require './BaseMixin'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'

###

component 'Button',
  render: ->
    …

oneoff = component
  render: ->
    …

wrapper = component (props) ->
  …

###
module.exports = (arg1, arg2) ->
  if isFunction(arg1)
    return componentWrapper(arg1)

  if isString(arg1)
    name = arg1
    spec = arg2
  else
    name = null
    spec = arg1

  spec.displayName = name if name?
  spec.mixins ||= []
  spec.mixins = [BaseMixin].concat(spec.mixins)
  reactClass = React.createClass(spec)
  component = componentWrapper React.createFactory(reactClass)
  component.reactClass = reactClass
  component

module.exports.PropTypes = React.PropTypes

componentWrapper = (wrapper) ->
  ->
    wrapper.apply(null, cloneProps(arguments))

cloneProps = (args) ->
  props = Object.clone(args[0] || {})
  props.style = Object.clone(props.style) if props.style?
  args[0] = props
  args





# resolveProps = (args) ->
#   props = {}
#   for argument in args
#     if isProps(arguments)
#       # I dont think we want to merge props here
#       # we def do want to set style and className
#       mergeProps(props, argument)
#     else
#       addChildren(props, argument)
#   props

# mergeProps = (props, newProps) ->
#   for p in newProps
#     switch p
#       when 'style'
#         props.style ||= {}
#         # todo make a style class here
#         Object.assign(props.style, newProps.style)
#       when 'className'
#         props.className ||= ''
#         props.className + ' ' + (newProps.className||'')
#       else
#         props[p] = newProps[p]

# addChildren = (props, children) ->
#   props.children ||= []
#   if !isArray(props.children)
#     props.children = [props.children]
#   if !isArray(children)
#     children = [children]
#   props.children = props.children.concat(children)


# isProps = (argument) ->
#   !isArray(argument) && !React.isValidElement(argument)

# module.exports = componentWrapper
