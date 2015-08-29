###

StyleComponentMixin

###
module.exports =
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

