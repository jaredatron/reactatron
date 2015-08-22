React = require 'react'

module.exports =

  getInitialState: ->
    @app = @context.app
    {}

  contextTypes:
    app: React.PropTypes.object.isRequired

  rerender: ->
    @forceUpdate()

  # app: ->
  #   @context.app
