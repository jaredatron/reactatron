React = require 'react'
ReactatronApp = require './App'

module.exports =

  contextTypes:
    # app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    app: React.PropTypes.object.isRequired

  getInitialState: ->
    @app = @context.app || @props.app # or console.warn('app not found')
    {}
