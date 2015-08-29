require 'stdlibjs/Object.clone'

React = require 'react'
BaseMixin = require './BaseMixin'
Style = require './Style'
isFunction = require 'stdlibjs/Function#wrap'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'
isArray = require 'stdlibjs/isArray'

###

Button = component 'Button',
  render: ->
    …

RedButton = Button.withDefaultProps
  style:

RedButton = Button.withStyle
  background: 'red'

RedButton = component (props) ->
  props.style.merge
    background: 'red'
  Button(props)

RedButton = component 'Button', (props) ->
  …

###
createComponent = (name, spec) ->
  return wrapWithPrepareProps(name) if isFunction(name)

  if isFunction(spec)
    render = spec
    spec = {
      render: -> render.call(this, @cloneProps())
    }

  spec.displayName = name if name?
  spec.mixins = [BaseMixin].concat(spec.mixins||[])
  reactClass = React.createClass(spec)
  component = React.createFactory(reactClass)
  extendComponent(component)
  component


extendComponent = (component) ->
  component.withStyle = withStyle
  component

wrapWithPrepareProps = (callback) ->
  extendComponent ->
    callback prepareProps.apply(null, arguments)

prepareProps = (props, children...) ->
  props = props? and Object.clone(props) or {}
  shoveChildrenIntoProps(props, children)
  props.style = new Style(props.style)
  props

shoveChildrenIntoProps = (props, children) ->
  props.children = mergeChildren(props.children, children)

# this might be an aweful idea :P
mergeChildren = (a, b) ->
  a ||= []
  return a unless b?
  a = [a] unless isArray(a)
  a.concat(b)


withStyle = (style) ->
  parentComponent = this
  wrapWithPrepareProps (props) ->
    props.style.update(style)
    parentComponent(props)

mergeStyle = (props, styles...) ->
  props.style = new Style(props.style).update(styles...)


createComponent.PropTypes = React.PropTypes
createComponent.mergeStyle = mergeStyle

module.exports = createComponent
