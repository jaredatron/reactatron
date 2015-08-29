component = require './component'
Block = require './Block'

module.exports = component 'ReactatronRedirect',

  componentDidMount: ->
    @app.setLocation @app.locationFor(@props.path, @props.params)

  render: ->
    Block {}, "redirecting to: #{@props.path}"
