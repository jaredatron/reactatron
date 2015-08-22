require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array.wrap'
require 'stdlibjs/Array#remove'

# EventEmitter = require 'eventemitter3'
# class Events extends EventEmitter

class Events
  constructor: ->
    Object.bindAll(this)
    @subscriptions = {}

  sub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      handlers = @subscriptions[event] ||= []
      handlers.push(handler)
    this

  unsub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      handlers = @subscriptions[event]
      if handlers
        handlers.remove(handler)
      if handlers.length == 0
        delete @subscriptions[event]
    this

  pub: (event, payload) ->
    handlers = @subscriptions[event]
    if handlers
      for handler in handlers
        handler(event, payload)
    this



module.exports = Events
