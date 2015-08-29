React = require 'react'
component = require './component'

DOM = {}

Object.keys(React.DOM).forEach (key) ->
  DOM[key] = component (props) ->
    React.createElement(key, props)

module.exports = DOM
