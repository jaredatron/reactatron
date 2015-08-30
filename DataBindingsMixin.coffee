React = require 'react'
ReactatronApp = require './App'
AppMixin = require './AppMixin'

module.exports =

  mixins: [AppMixin]

  getInitialState: ->
    @getData()

  componentWillMount: ->
    @subscribeToStoreChanges()

  componentWillReceiveProps: (nextProps) ->
    @resubscribeToStoreChanges(nextProps)

  componentWillUpdate: ->
    # console.log("componentWillUpdate", @_UUID, @constructor.displayName)
    # console.time("update #{@_UUID}")

  componentDidUpdate: ->
    # console.timeEnd("update #{@_UUID}")

  componentWillUnmount: ->
    @unsubscribefromStoreChanges()


  ###

  Helpers

  ###

  _getDataBindings: (props=@props) ->
    @dataBindings.call(null, props)

  getData: ->
    data = {}
    for stateKey, storeKey of @_getDataBindings()
      data[stateKey] = @app.get(storeKey)
    data

  storeChange: (event, key) ->
    return unless @isMounted()
    @app.stats.storeChangeRerenders++
    stateKeys = []
    for stateKey, storeKey of @_getDataBindings()
      if key == storeKey
        stateKeys.push stateKey
    return if stateKeys.length == 0
    changes = setKeys({}, stateKeys, @app.get(storeKey))
    @setState(changes)

  subscribeToStoreChanges: (props=@props) ->
    for stateKey, storeKey of @_getDataBindings(props)
      @app.sub "store:change:#{storeKey}", @storeChange

  unsubscribefromStoreChanges: ->
    for stateKey, storeKey of @_getDataBindings()
      @app.unsub "store:change:#{storeKey}", @storeChange

  resubscribeToStoreChanges: (props) ->


setKeys = (object, keys, value) ->
  object[key] = value for key in keys
  object
