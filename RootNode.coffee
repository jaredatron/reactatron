React = require 'react'

component = require './component'

module.exports = component 'RootNode',
  render: ->
    React.DOM.div(null, 'ROOT NODE')
