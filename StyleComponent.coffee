require 'stdlibjs/Object.clone'
React = require 'react'
Style = require './Style'
createFactory = require './createFactory'

###

StyleComponent

###

types = Object.keys(React.DOM)

module.exports = createFactory React.createClass

  displayName: 'StyleComponent'

  propTypes:
    type:  React.PropTypes.oneOf(types).isRequired
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
    if style[':mousedown']?
      node = @getDOMNode()
      node.ownerDocument.addEventListener 'mouseup', @onMouseUp

  componentWillUnmount: ->
    node = @getDOMNode()
    node.ownerDocument.removeEventListener 'mouseup', @onMouseUp


  render: ->
    style = new Style(@props.style)
    props = Object.clone(@props)
    delete props.type
    props.style = style.compute(@state)

    if style[':hover']?
      props.onMouseEnter = @onMouseEnter
      props.onMouseLeave = @onMouseLeave

    if style[':focus']?
      props.onFocus      = @onFocus
      props.onBlur       = @onBlur

    if style[':mousedown']?
      props.onMouseDown  = @onMouseDown
      # props.onMouseUp    = @onMouseUp

    console.log('StyleComponent', props)
    React.createElement(@props.type, props)

















