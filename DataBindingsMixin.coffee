require 'stdlibjs/Object.values'
require 'stdlibjs/Array#unique'
require 'stdlibjs/Array#excludes'

React = require 'react'
ReactatronApp = require './App'
AppMixin = require './AppMixin'

module.exports =

  mixins: [AppMixin]

  getInitialState: ->
    @getStateFromStore()

  componentWillMount: ->
    @subscribeToStoreChanges()

  componentWillReceiveProps: (nextProps) ->
    @resubscribeToStoreChanges(nextProps)

  componentWillUnmount: ->
    @unsubscribefromStoreChanges()


  ###

  Helpers

  ###

  getStateFromStore: (dataBindings) ->
    dataBindings ||= @dataBindings(@props)
    stateKeys = Object.keys(dataBindings)
    storeKeys = valuesFor(dataBindings, stateKeys).unique()

    data = {}
    for storeKey in storeKeys
      data[storeKey] = @app.get(storeKey)

    state = {}
    for stateKey in stateKeys
      state[stateKey] = data[dataBindings[stateKey]]
    state

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

    return if currentStoreKeys.length == 0 && nextStoreKeys.length == 0

    newStoreKeys = nextStoreKeys.filter (key) ->
      currentStoreKeys.excludes(key)

    oldStoreKeys = currentStoreKeys.filter (key) ->
      nextStoreKeys.excludes(key)

    return if newStoreKeys.length == 0 && oldStoreKeys.length == 0

    for storeKey in oldStoreKeys
      @app.unsub "store:change:#{storeKey}", @storeChange

    for storeKey in nextStoreKeys
      @app.sub "store:change:#{storeKey}", @storeChange

    dataBindingsThatNeedUpdating = {}
    for newStoreKey in nextStoreKeys
      for stateKey, storeKey of nextDataBindings
        if storeKey == newStoreKey
          dataBindingsThatNeedUpdating[stateKey] = storeKey

    state = @getStateFromStore(dataBindingsThatNeedUpdating)
    console.log('resubscribeToStoreChanges', state)
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


valuesFor = (object, keys) ->
  values = []
  values.push(object[key]) for key in keys
  values
