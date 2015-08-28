require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array.wrap'
require 'stdlibjs/Array#remove'
require 'stdlibjs/Array#includes'
isString = require 'stdlibjs/isString'

class Events
  constructor: ->
    Object.bindAll(this)
    @publishingTimeout = null
    @subscriptions = {}
    @publishings = []
    @_clearQueueCallbacks = []

  sub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      subscriptions = @subscriptions[event] ||= []
      subscriptions.push handler unless subscriptions.includes handler
    this

  unsub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      if subscriptions = @subscriptions[event]
        subscriptions.remove(handler)
        if subscriptions.length == 0
          delete @subscriptions[event]
    this

  pub: (event, payload, done) ->
    @_schedulePublishing(event, payload, done)
    this


  waitForClearQueue: (callback) ->
    @_clearQueueCallbacks.push callback

  _schedulePublishing: (event, payload, done) ->
    @publishings.push [event, payload, done]
    @publishingTimeout ||= setTimeout(@_publish)

  _publish: ->
    clearTimeout(@publishingTimeout)
    @publishingTimeout = null

    publishings = @publishings
    @publishings = []

    clearQueueCallbacks = @_clearQueueCallbacks
    @_clearQueueCallbacks = []

    keys = publishings.map (p) -> p[0]
    console.info('Events#_publish', keys, publishings)
    for [event, payload, done] in publishings
      subscriptions = @subscriptions[event] || []
      subscriptions = subscriptions.concat(@subscriptions['*'] || [])
      for handler in subscriptions
        handler(event, payload)
      done(event, payload) if done

    for callback in clearQueueCallbacks
      callback(publishings)

    this


module.exports = Events
