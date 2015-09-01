require 'stdlibjs/Object.clone'
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
    @setState hover: true
    @props.onMouseEnter?()

  onMouseLeave: ->
    @setState hover: false
    @props.onMouseLeave?()

  onFocus: ->
    @setState focus: true
    @props.onFocus?()

  onBlur: ->
    @setState focus: false
    @props.onBlur?()

  onMouseDown: ->
    @setState mousedown: true
    @props.onMouseDown?()

  onMouseUp: ->
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

  # shouldComponentUpdate: (nextProps, nextState) ->
  #   # @app.stats.styledComponentRerenders++
  #   console.log('STYLE UPDATE?', @state, nextState)
  #   true


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







