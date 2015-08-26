component = require './component'
Style = require './Style'

###

Box = styledComponent 'Box', div,
  display: 'inline-block'


###
module.exports = (name, targetComponent, style) ->
  extendStyledComponent.apply(
    {style: new Style, targetComponent: targetComponent},
    [name, style],
  )

extendStyledComponent = (name, style) ->
  style = @style.merge(style)
  targetComponent = @targetComponent

  spec =
    mixins: []
    render: ->
      props = @cloneProps()
      props.style = style.merge(props.style).compute(@state)
      targetComponent(props)

  # TODO break up mixins
  spec.mixins.push StyleComponent

  styledComponent = component(name, spec)
  styledComponent.isStyledComponent = true
  styledComponent.style = style
  styledComponent.targetComponent = targetComponent
  styledComponent.extendStyledComponent = extendStyledComponent
  styledComponent



StyleComponent =

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

    # if @props.style[':hover']
    node.addEventListener 'mouseenter', @onMouseenter
    node.addEventListener 'mouseleave', @onMouseleave

    # if @props.style[':focus']
    node.addEventListener 'focus', @onFocus
    node.addEventListener 'blur', @onBlur

    # if @props.style[':mousedown']
    node.addEventListener 'mousedown', @onMousedown
    document.body.addEventListener 'mouseup', @onMouseup

  componentWillUnmount: ->
    node = @getDOMNode()

    # if @props.style[':hover']
    node.removeEventListener 'mouseenter', @onMouseenter
    node.removeEventListener 'mouseleave', @onMouseleave

    # if @props.style[':focus']
    node.removeEventListener 'focus', @onFocus
    node.removeEventListener 'blur', @onBlur

    # if @props.style[':mousedown']
    node.removeEventListener 'mousedown', @onMousedown
    document.body.removeEventListener 'mouseup', @onMouseup

