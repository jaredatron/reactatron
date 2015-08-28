require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array.wrap'
require 'stdlibjs/Array#remove'
isString = require 'stdlibjs/isString'

class Events
  constructor: ->
    Object.bindAll(this)
    @subscriptions = {}

  sub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      subscriptions = @subscriptions[event] ||= []
      subscriptions.push handler
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
    subscriptions = @subscriptions[event] || []
    subscriptions = subscriptions.concat(@subscriptions['*'] || [])
    for handler in subscriptions
      handler(event, payload)
    done(event, payload) if done
    this

module.exports = Events
