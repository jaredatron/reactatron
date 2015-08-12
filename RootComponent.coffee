React = require 'react'
component = require './component'

module.exports = component 'Root',

  propTypes:
    path:         React.PropTypes.string.isRequired
    params:       React.PropTypes.object.isRequired
    page:         React.PropTypes.element.isRequired

    locationFor:  React.PropTypes.func.isRequired
    setPath:      React.PropTypes.func.isRequired
    setParams:    React.PropTypes.func.isRequired
    updateParams: React.PropTypes.func.isRequired


  childContextTypes:
    path:         React.PropTypes.string
    params:       React.PropTypes.object
    locationFor:  React.PropTypes.func
    setPath:      React.PropTypes.func
    setParams:    React.PropTypes.func
    updateParams: React.PropTypes.func

  getChildContext: ->
    @props

  render: ->
    @props.page()