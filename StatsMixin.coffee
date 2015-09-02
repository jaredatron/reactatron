AppMixin = require './AppMixin'

module.exports =
  mixins: [AppMixin]

  getInitialState: ->
    @app?.stats?.componentsInitialized++
    {}

  componentDidMount: ->
    @app?.stats?.componentsMounted++

  componentDidUpdate: ->
    @app?.stats?.componentsUpdated++
