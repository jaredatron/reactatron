createComponent = require './component'
Style = require './Style'

###

Box = styledComponent 'Box', div,
  display: 'inline-block'

Block = styledComponent 'Block', box,
  displayL 'inline-block'

###
module.exports = (name, component, style) ->
  if component.isStyledComponent
    # subclass styled component
    newComponent = createComponent name, (props) ->
      props.style = newComponent.style.merge(props.style)
      newComponent.targetComponent(props)
    newComponent.style = component.style.merge(style)
    newComponent.targetComponent = component.targetComponent
  else
    # root styled component
    newComponent = createComponent name, (props) ->
      props.style = newComponent.style.merge(props.style)
      props.component = newComponent.targetComponent
      StyleComponent.call(null, props)
    newComponent.targetComponent = component
    newComponent.style = new Style(style)

  newComponent.isStyledComponent = true
  newComponent


StyleComponent = createComponent 'Style',

  getDefaultProps: ->
    style: {}

  getInitialState: ->
    hover: false
    focused: false
    mousedown: false

  onMouseenter: ->
    @setState hover: true

  onMouseleave: ->
    @setState hover: false

  onFocus: ->
    @setState focus: true

  onBlur: ->
    @setState focus: false

  onMousedown: ->
    @setState mousedown: true

  onMouseup: ->
    @setState mousedown: false

  componentDidMount: ->
    node = @getDOMNode()

    if @props.style[':hover']
      node.addEventListener 'mouseenter', @onMouseenter
      node.addEventListener 'mouseleave', @onMouseleave

    if @props.style[':focus']
      node.addEventListener 'focus', @onFocus
      node.addEventListener 'blur', @onBlur

    if @props.style[':mousedown']
      node.addEventListener 'mousedown', @onMousedown
      document.body.addEventListener 'mouseup', @onMouseup

  componentWillUnmount: ->
    node = @getDOMNode()

    if @props.style[':hover']
      node.removeEventListener 'mouseenter', @onMouseenter
      node.removeEventListener 'mouseleave', @onMouseleave

    if @props.style[':focus']
      node.removeEventListener 'focus', @onFocus
      node.removeEventListener 'blur', @onBlur

    if @props.style[':mousedown']
      node.removeEventListener 'mousedown', @onMousedown
      document.body.removeEventListener 'mouseup', @onMouseup

  render: ->
    props = @cloneProps()
    props.style = new Style(@props.style).compute(@state)
    @props.component(props)
