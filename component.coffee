require 'stdlibjs/Object.clone'
require 'stdlibjs/Array#unique'
toArray = require 'stdlibjs/toArray'
isObject = require 'stdlibjs/isObject'
isFunction = require 'stdlibjs/Function#wrap'
isFunction = require 'stdlibjs/isFunction'
isString = require 'stdlibjs/isString'
isArray = require 'stdlibjs/isArray'

React = require 'react'
BaseMixin = require './BaseMixin'
AppMixin = require './AppMixin'
DataBindingsMixin = require './DataBindingsMixin'
Style = require './Style'
createFactory = require './createFactory'
prepareProps = require './prepareProps'

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
  detectMixins(spec)
  reactClass = React.createClass(spec)
  component = createFactory(reactClass)
  extendComponent(component)
  component.displayName = name
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


extendComponent = (component) ->
  component.wrapComponent = wrapComponent
  component.withStyle = withStyle
  component.withDefaultProps = withDefaultProps
  component

wrapWithPrepareProps = (component) ->
  extendComponent ->
    # console.log('prepareProps', arguments, prepareProps.apply(null, arguments))
    component prepareProps.apply(null, arguments)


withStyle = (name, style) ->
  if this.isStyledComponent
    return this.unstyled.withStyle(name, this.style.merge(style))

  component = createComponent name, (props) ->
    props.style = component.style.merge(props.style)
    component.unstyled(props)
  component.style = new Style(style)
  component.unstyled = this
  component.isStyledComponent = true
  component

withDefaultProps = (defaultProps) ->
  parentComponent = this
  defaultProps = Props(defaultProps)
  wrapWithPrepareProps (props) ->
    parentComponent props.reverseExtend(defaultProps)

wrapComponent = (wrapper) ->
  parentComponent = this
  createComponent (props) ->
    parentComponent(wrapper.call(this, props))


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
