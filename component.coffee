require 'stdlibjs/Object.clone'
require 'stdlibjs/Array#unique'
toArray = require 'stdlibjs/toArray'
isObject = require 'stdlibjs/isObject'
isFunction = require 'stdlibjs/Function#wrap'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'
isArray = require 'stdlibjs/isArray'

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
    props = Props(prepareProps(arguments))
    wrapper(props)
  extendComponent(component)
  component


call_render = -> @_render.call(this, Props(@props))
createComponent = (name, spec) ->
  if isFunction(spec)
    render = spec
    spec = {_render: spec, render: call_render}
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
