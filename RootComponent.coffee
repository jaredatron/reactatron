component = require './component'

module.exports = component 'RootComponent',

  propTypes:
    path:         component.PropTypes.string.isRequired
    params:       component.PropTypes.object.isRequired
    page:         component.PropTypes.func.isRequired

    locationFor:  component.PropTypes.func.isRequired
    setLocation:  component.PropTypes.func.isRequired
    setPath:      component.PropTypes.func.isRequired
    setParams:    component.PropTypes.func.isRequired
    updateParams: component.PropTypes.func.isRequired

  childContextTypes:
    path:         component.PropTypes.string
    params:       component.PropTypes.object
    setLocation:  component.PropTypes.func
    locationFor:  component.PropTypes.func
    setPath:      component.PropTypes.func
    setParams:    component.PropTypes.func
    updateParams: component.PropTypes.func

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
