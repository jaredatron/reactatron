React = require 'react'
component = require './component'

StyleComponent = require './StyleComponent'

DOM = {}

Object.keys(React.DOM).forEach (type) ->
  DOM[type] = component (props) ->
    # if props.style.needsControl()
    props.type = type
    StyleComponent(props)
    # else
    #   React.createElement(type, props)

module.exports = DOM



