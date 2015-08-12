React = require 'react'
component = require './component'

module.exports = component 'Root',

  propTypes:
    path:         React.PropTypes.string.isRequired
    params:       React.PropTypes.object.isRequired
    page:         React.PropTypes.func.isRequired

    locationFor:  React.PropTypes.func.isRequired
    setLocation:  React.PropTypes.func.isRequired
    setPath:      React.PropTypes.func.isRequired
    setParams:    React.PropTypes.func.isRequired
    updateParams: React.PropTypes.func.isRequired


  childContextTypes:
    path:         React.PropTypes.string
    params:       React.PropTypes.object
    setLocation:  React.PropTypes.func
    locationFor:  React.PropTypes.func
    setPath:      React.PropTypes.func
    setParams:    React.PropTypes.func
    updateParams: React.PropTypes.func

  getChildContext: ->
    path:         @props.path
    params:       @props.params
    setLocation:  @props.setLocation
    locationFor:  @props.locationFor
    setPath:      @props.setPath
    setParams:    @props.setParams
    updateParams: @props.updateParams

  render: ->
    @props.page()
