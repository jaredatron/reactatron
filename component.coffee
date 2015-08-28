React = require 'react'
BaseMixin = require './BaseMixin'
Style = require './Style'
isFunction = require 'stdlibjs/Function#wrap'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'
isArray = require 'stdlibjs/isArray'




# React.createElement = React.createElement.wrap ($createElement, type, props, children) ->
#   return type(props, children) if isFunction(type)
#   return $createElement.call(this, type, props, children)



###

component 'Button',
  render: ->
    …

oneoff = component
  render: ->
    …

# short hand for just render
Button = component 'Button', (props) ->
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

  if isFunction(spec)
    render = spec
    spec = {
      render: -> render(@cloneProps())
    }

  spec.displayName = name if name?
  spec.mixins ||= []
  spec.mixins = [BaseMixin].concat(spec.mixins)
  reactClass = React.createClass(spec)
  component = componentWrapper React.createFactory(reactClass)
  component.type = reactClass
  component.reactClass = reactClass
  component.style
  component

module.exports.PropTypes = React.PropTypes

componentWrapper = (component) ->
  newComponent = ->
    component.apply(null, cloneProps(arguments))
  newComponent.wrapsComponent = component
  newComponent

cloneProps = (args) ->
  children = [].slice.call(args, 1)
  props = Object.clone(args[0] || {})
  props.style = new Style(props.style)
  props.children = mergeChildren(props.children, children)
  args[0] = props
  args


# this might be an aweful ideas :P
mergeChildren = (a, b) ->
  a = [a] unless isArray(a)
  a.concat(b)




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
