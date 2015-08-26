component = require './component'
Style = require './Style'

module.exports = (component, style) ->
  style = new Style(style)
  (props) ->
    props ||= {}
    props.style = style.merge(props.style)
    props.component = component
    StyleComponent.apply(null, arguments)


StyleComponent = component 'Style',

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
    node.addEventListener 'mouseenter', @onMouseenter
    node.addEventListener 'mouseleave', @onMouseleave
    node.addEventListener 'focus', @onFocus
    node.addEventListener 'blur', @onBlur
    node.addEventListener 'mousedown', @onMousedown
    document.body.addEventListener 'mouseup', @onMouseup

  componentWillUnmount: ->
    node = @getDOMNode()
    node.removeEventListener 'mouseenter', @onMouseenter
    node.removeEventListener 'mouseleave', @onMouseleave
    node.removeEventListener 'focus', @onFocus
    node.removeEventListener 'blur', @onBlur
    node.removeEventListener 'mousedown', @onMousedown
    document.body.removeEventListener 'mouseup', @onMouseup

  render: ->
    props = @cloneProps()
    props.style = new Style(@props.style).compute(@state)
    @props.component(props)
