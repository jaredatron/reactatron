require 'shouldhave/Object.clone'
React = require './React'
Style = require './Style'
component = require './component'

###

StyleComponent

###

types = Object.keys(React.DOM)

module.exports = component 'StyleComponent',

  propTypes:
    _type:  React.PropTypes.oneOf(types).isRequired
    style: React.PropTypes.object

  getInitialState: ->
    hover: false
    focused: false
    mousedown: false

  onMouseEnter: ->
    return if @state.hover
    # console.info('onMouseEnter', @getDOMNode().nodeName, @props.style)
    @setState hover: true
    @props.onMouseEnter?()

  onMouseLeave: ->
    return if !@state.hover
    # console.info('onMouseLeave', @getDOMNode().nodeName, @props.style)
    @setState hover: false
    @props.onMouseLeave?()

  onFocus: ->
    return if @state.focus
    # console.info('onFocus', @getDOMNode().nodeName, @props.style)
    @setState focus: true
    @props.onFocus?()

  onBlur: ->
    return if !@state.focus
    # console.info('onBlur', @getDOMNode().nodeName, @props.style)
    @setState focus: false
    @props.onBlur?()

  onMouseDown: ->
    return if @state.mousedown
    # console.info('onMouseDown', @state.mousedown, @getDOMNode().nodeName, @props.style)
    @setState mousedown: true
    @props.onMouseDown?()

  onMouseUp: ->
    return if !@state.mousedown
    # console.info('onMouseUp', @state.mousedown, @getDOMNode().nodeName, @props.style)
    @setState mousedown: false
    @props.onMouseUp?()

  componentDidMount: ->
    style = new Style(@props.style)
    node = @getDOMNode()
    if style[':mousedown']?
      node.ownerDocument.addEventListener 'mouseup', @onMouseUp

    # Why doesnt react support onFocusIn

    if @props.onFocusIn
      node.addEventListener 'focusin', @props.onFocusIn

    if @props.onFocusOut
      node.addEventListener 'focusout', @props.onFocusOut

  shouldComponentUpdate: (nextProps, nextState) ->
    true
    # console.info('StyleComponent shouldComponentUpdate?', @state, nextState, @props, nextProps)
    # for key in @state
    #   return true if @state[key] != nextState[key]

    # for key in ['_type', 'children']
    # @props._type != nextProps._type

    # false


  componentWillUnmount: ->
    node = @getDOMNode()
    node.ownerDocument.removeEventListener 'mouseup', @onMouseUp
    node.addEventListener 'focusin', @props.onFocusIn
    node.addEventListener 'focusout', @props.onFocusOut

  # componentDidUpdate: (prevProps, prevStats) ->
  #   style = new Style(@props.style).compute(@state)
  #   prevStyle = new Style(prevProps.style).compute(prevStats)
  #   diff = differemce(style, prevStyle)
  #   console.log('StyleComponent update', diff) if diff

  computedStyle: ->
    new Style(@props.style).compute(@state)

  render: ->
    # console.log('StyleComponent render', @state, @props)
    style = @props.style || {}
    props = @extendProps
      _type: undefined
      style: @computedStyle()

    if style[':hover']?
      props.onMouseEnter = @onMouseEnter
      props.onMouseLeave = @onMouseLeave

    if style[':focus']?
      props.onFocus      = @onFocus
      props.onBlur       = @onBlur

    if style[':mousedown']?
      props.onMouseDown  = @onMouseDown
      # props.onMouseUp    = @onMouseUp

    React.createElement(@props._type, props)








# differemce = (a,b) ->
#   diff = {}
#   for key, aValue of a
#     bValue = b[key]
#     continue if aValue == aValue
#     diff[key] = [aValue, bValue]

#   for key, bValue of b
#     aValue = a[key]
#     continue if bValue == aValue
#     diff[key] = [aValue, bValue]

#   return diff if Object.keys(diff).length > 0







