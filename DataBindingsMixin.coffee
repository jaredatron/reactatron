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

  componentWillReceiveProps: (nextProps) ->
    @resubscribeToStoreChanges(nextProps)

  componentWillUnmount: ->
    @unsubscribefromStoreChanges()


  ###

  Helpers

  ###

  getData: ->
    data = {}
    for stateKey, storeKey of @dataBindings(@props)
      data[stateKey] = @app.get(storeKey)
    data

  storeChange: (event, storeKey) ->
    return unless @isMounted()
    @app.stats.storeChangeEvents++
    @scheduleDataRefresh(storeKey)

  scheduleDataRefresh: (storeKey) ->
    @_changedStoreKeys ||= []
    @_changedStoreKeys.push(storeKey) if @_changedStoreKeys.excludes(storeKey)
    return if @_dataRefreshTimeout
    @_dataRefreshTimeout = setTimeout(@refreshData)

  refreshData: ->
    return unless @isMounted()
    delete @_dataRefreshTimeout
    changedStoreKeys = @_changedStoreKeys
    return if !changedStoreKeys?  || changedStoreKeys.length == 0
    @app.stats.storeChangeRerenders++
    dataBindings = @dataBindings(@props)
    changes = {}
    changedStoreKeys.forEach (changedStoreKey) =>
      stateKeys = keysWithValue(dataBindings, changedStoreKey)
      if stateKeys.length > 0
        setKeys(changes, stateKeys, @app.get(changedStoreKey))
    @setState(changes)



  subscribeToStoreChanges: (props=@props) ->
    for stateKey, storeKey of @dataBindings(props)
      @app.sub "store:change:#{storeKey}", @storeChange

  unsubscribefromStoreChanges: ->
    for stateKey, storeKey of @dataBindings(@props)
      @app.unsub "store:change:#{storeKey}", @storeChange

  resubscribeToStoreChanges: (props) ->
    currentDataBindings = @dataBindings(@props)
    nextDataBindings    = @dataBindings(props)
    currentStoreKeys    = Object.values(currentDataBindings).unique()
    nextStoreKeys       = Object.values(nextDataBindings).unique()

    newStoreKeys = nextStoreKeys.filter (key) ->
      currentStoreKeys.excludes(key)

    oldStoreKeys = currentStoreKeys.filter (key) ->
      nextStoreKeys.excludes(key)

    console.log('resubscribeToStoreChanges', oldStoreKeys, newStoreKeys)

    for storeKey in oldStoreKeys
      # all the stateKeys for the given storeKey
      # stateKeysFor(nextDataBindings, storeKey)
      @app.unsub "store:change:#{storeKey}", @storeChange

    for storeKey in nextStoreKeys
      @app.sub "store:change:#{storeKey}", @storeChange

    stateKeysThatNeedUpdating = []
    for newStoreKey in nextStoreKeys
      for stateKey, storeKey of nextDataBindings
        if storeKey == newStoreKey
          stateKeysThatNeedUpdating.push(stateKey)

    cache = {}
    state = {}
    for stateKey in stateKeysThatNeedUpdating
      storeKey = nextDataBindings[stateKey]
      state[stateKey] = cache[storeKey] ||= @app.get(storeKey)
    @setState(state)




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
