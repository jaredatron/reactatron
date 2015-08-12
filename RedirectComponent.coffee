component = require './component'
DOM = require './DOM'

module.exports = component
  displayName: 'ReactatronRedirect'
  propTypes:
    path: component.PropTypes.string.isRequired
    params: component.PropTypes.object.isRequired
  contextTypes:
    setLocation: component.PropTypes.func.isRequired
  componentDidMount: ->
    @context.setLocation(@props.path, @props.params)
  render: ->
    DOM.div(null, "redirecting to: #{@props.path}")
