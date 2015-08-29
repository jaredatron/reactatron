require 'stdlibjs/Object.clone'
isObject = require 'stdlibjs/isObject'
isFunction = require 'stdlibjs/Function#wrap'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'
isArray = require 'stdlibjs/isArray'

React = require 'react'
BaseMixin = require './BaseMixin'
Style = require './Style'
createFactory = require './createFactory'

###


Button = component 'Button',
  render: ->
    …

Button = component 'Button', (props) ->
  …


RedButton = component (props) ->
  props.style.merge
    background: 'red'
  Button(props)


RedButton = Button.withDefaultProps
  style:


RedButton = Button.withStyle 'RedButton',
  background: 'red'


###
createComponent = (name, spec) ->
  return wrapWithPrepareProps(name) if isFunction(name)

  # TODO deprecate this
  if isObject(name)
    throw new Error('this API is deprecated')

  if isFunction(spec)
    render = spec
    spec = {
      render: -> render.call(this, @cloneProps())
    }

  spec.displayName = name
  spec.mixins = [BaseMixin].concat(spec.mixins||[])
  reactClass = React.createClass(spec)
  component = wrapWithPrepareProps createFactory(reactClass)
  # extendComponent(component)
  component.displayName = name
  component


extendComponent = (component) ->
  component.withStyle = withStyle
  component.withDefaultProps = withDefaultProps
  component

wrapWithPrepareProps = (component) ->
  extendComponent ->
    component prepareProps.apply(null, arguments)

prepareProps = (props, children...) ->
  props = props? and Object.clone(props) or {}
  shoveChildrenIntoProps(props, children)
  props.style = new Style(props.style)
  props

shoveChildrenIntoProps = (props, children) ->
  props.children = mergeChildren(props.children, children)

# this might be an aweful idea :P
mergeChildren = (a, b) ->
  return a unless b?
  a = []  unless a?
  a = [a] unless isArray(a)
  a.concat(b)


withStyle = (name, style, debugCallback) ->
  style = new Style(style)
  parentComponent = this
  component = createComponent name, (props) ->
    props.style = style.merge(props.style)
    parentComponent(props)
  component

withDefaultProps = (defaultProps) ->
  parentComponent = this
  wrapWithPrepareProps (props) ->
    props = mergeProps(defaultProps, props)
    parentComponent(props)

mergeStyle = (props, styles...) ->
  props.style = new Style(props.style).update(styles...)

mergeProps = (args...) ->
  mergedStyle = new Style
  mergedProps = {}
  for props in args
    mergedStyle.update(props.style)
    Object.assign(mergedProps, props)
  mergedProps.style = mergedStyle
  mergedProps

createComponent.PropTypes = React.PropTypes
createComponent.mergeStyle = mergeStyle
createComponent.withDefaultProps = (component, props) ->
  withDefaultProps.call(component, props)

module.exports = createComponent
