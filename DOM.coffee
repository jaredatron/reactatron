React = require './React'
component = require './component'

StyleComponent = require './StyleComponent'

DOM = {}

Object.keys(React.DOM).forEach (type) ->
  DOM[type] = component (props={}) ->
    props._type = type
    StyleComponent(props)

module.exports = DOM



