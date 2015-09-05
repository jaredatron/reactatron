require 'shouldhave/Object.clone'
require 'shouldhave/Array#unique'
toArray = require 'shouldhave/toArray'
isObject = require 'shouldhave/isObject'
isFunction = require 'shouldhave/Function#wrap'
isFunction = require 'shouldhave/isFunction'
isString = require 'shouldhave/isString'
isArray = require 'shouldhave/isArray'

React = require './React'
BaseMixin = require './BaseMixin'
AppMixin = require './AppMixin'
DataBindingsMixin = require './DataBindingsMixin'
Style = require './Style'
Props = require './Props'
prepareProps = require './prepareProps'
createClass = require './createClass'

###

# Create a standard Reactatron Component
Button = component 'Button',
  render: ->
    …

# Shorthand for a standard Reactatron Component
Button = component 'Button', (props) ->
  …

# Component wrapper
RedButton = component (props) ->
  props.style.merge
    background: 'red'
  Button(props)


RedButton = Button.withDefaultProps
  style:


RedButton = Button.withStyle 'RedButton',
  background: 'red'


###
module.exports = exports = ->
  switch arguments.length
    when 1
      createComponentWrapper(arguments[0])
    when 2
      createComponent(arguments[0], arguments[1])
    else
      throw new 'arrrrgument errrrr'


exports.PropTypes = React.PropTypes

extendComponent = (component) ->
  Object.assign(component, prototype)

exports.prototype = prototype =

  wrapComponent: (wrapper) ->
    wrapComponent(this, wrapper)

  withDefaultProps: (defaultProps) ->
    @wrapComponent (props) ->
      props.reverseExtend(defaultProps)

  withStyle: (name, style) ->
    if this.isStyledComponent
      return this.unstyled.withStyle(name, this.style.merge(style))

    component = createComponent name, (props) ->
      props.style = component.style.merge(props.style)
      component.unstyled(props)
    component.style = new Style(style)
    component.unstyled = this
    component.isStyledComponent = true
    component




wrapComponent = (component, wrapper) ->
  ->
    props = Props(prepareProps(arguments))
    component(wrapper(props))

createComponentWrapper = (wrapper) ->
  component = ->
    if this instanceof component
      throw new Error('do we need to make this work?')
    props = Props(prepareProps(arguments))
    wrapper(props)
  extendComponent(component)
  component


call_render = -> @_render.call(this, Props(@props))
createComponent = (name, spec) ->
  throw new Error('expected component name to be string') if 'string' != typeof name
  if isFunction(spec)
    render = spec
    spec = {_render: spec, render: call_render}
  throw new Error('expected component spec to be object') if 'object' != typeof spec
  spec.displayName = name
  detectMixins(spec)
  component = createClass(spec)
  extendComponent(component)
  component

detectMixins = (spec) ->
  spec.mixins ||= []
  addMixin(spec, BaseMixin)
  addMixin(spec, DataBindingsMixin) if spec.dataBindings
  spec.mixins = spec.mixins.unique()

addMixin = (spec, mixin) ->
  toArray(mixin.mixins).forEach (mixin) ->
    addMixin(spec, mixin)
  spec.mixins.push mixin
