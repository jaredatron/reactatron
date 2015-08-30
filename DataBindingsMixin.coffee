require 'stdlibjs/Object.values'
require 'stdlibjs/Array#unique'
require 'stdlibjs/Array#excludes'

React = require 'react'
ReactatronApp = require './App'
AppMixin = require './AppMixin'

module.exports =

  mixins: [AppMixin]

  getInitialState: ->
    @getData()

  componentWillMount: ->
    @subscribeToStoreChanges()

  componentDidUpdate: (nextProps, nextState) ->
    @resubscribeToStoreChanges(nextProps)

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
    @app.stats.storeChangeEvents++
    @_changedStoreKeys ||= []
    if @_changedStoreKeys.excludes(key)
      @_changedStoreKeys.push(key)
    if @_changedStoreKeys.length > 0
      @scheduleDataRefresh()

  scheduleDataRefresh: ->
    return if @_dataRefreshTimeout
    @_dataRefreshTimeout = setTimeout(@refreshData)

  refreshData: ->
    delete @_dataRefreshTimeout
    changedStoreKeys = @_changedStoreKeys
    return if !changedStoreKeys?  || changedStoreKeys.length == 0
    @app.stats.storeChangeRerenders++
    dataBindings = @_getDataBindings()
    changes = {}
    changedStoreKeys.forEach (changedStoreKey) =>
      stateKeys = keysWithValue(dataBindings, changedStoreKey)
      if stateKeys.length > 0
        setKeys(changes, stateKeys, @app.get(changedStoreKey))
    @setState(changes)



  subscribeToStoreChanges: (props=@props) ->
    for stateKey, storeKey of @_getDataBindings(props)
      @app.sub "store:change:#{storeKey}", @storeChange

  unsubscribefromStoreChanges: ->
    for stateKey, storeKey of @_getDataBindings()
      @app.unsub "store:change:#{storeKey}", @storeChange

  resubscribeToStoreChanges: (props) ->
    currentStoreKeys = Object.values(@_getDataBindings()).unique()
    nextStoreKeys    = Object.values(@_getDataBindings(props)).unique()
    for storeKey in currentStoreKeys
      if nextStoreKeys.excludes(storeKey)
        @app.unsub "store:change:#{storeKey}", @storeChange
    for storeKey in nextStoreKeys
      if currentStoreKeys.excludes(storeKey)
        @app.sub "store:change:#{storeKey}", @storeChange


setKeys = (object, keys, value) ->
  for key in keys
    object[key] = value
  object


keysWithValue = (object, value) ->
  keys = []
  for k, v of object
    keys.push(k) if v == value
  keys

setKeys = (object, keys, value) ->
  object[key] = value for key in keys
  object
