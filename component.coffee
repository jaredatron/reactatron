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
Props = require './Props'
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
module.exports = ->
  switch arguments.length
    when 1
      createComponentWrapper(arguments[0])
    when 2
      createComponent(arguments[0], arguments[1])
    else
      throw new 'arrrrgument errrrr'


module.exports.PropTypes = React.PropTypes



createComponentWrapper = (component) ->
  wrapWithPrepareProps(component)



createComponent = (name, spec) ->
  if isFunction(spec)
    render = spec
    spec = {
      render: -> render.call(this, Props(props))
    }
  spec.displayName = name
  detectMixins(spec)
  component = createFactory React.createClass(spec)
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





extendComponent = (component) ->
  component.wrapComponent = wrapComponent
  component.withStyle = withStyle
  component.withDefaultProps = withDefaultProps
  component

wrapWithPrepareProps = (parentComponent) ->
  component = ->
    parentComponent(prepareProps(arguments))
  component.type = parentComponent.type
  extendComponent(component)
  component






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

