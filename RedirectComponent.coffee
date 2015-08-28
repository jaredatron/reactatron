component = require './component'
DOM = require './DOM'

module.exports = component 'ReactatronRedirect',
  componentDidMount: ->
    @app.setLocation @app.locationFor(@props.path, @props.params)
  render: ->
    DOM.div(null, "redirecting to: #{@props.path}")
