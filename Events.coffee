require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array.wrap'
require 'stdlibjs/Array#remove'

class Events
  constructor: ->
    Object.bindAll(this)
    @subscriptions = []

  sub: (events, handler) ->
    events = Array.wrap(events)
    for event in events
      @subscriptions.push [event, handler]
    this

  unsub: (events, handler) ->
    events = Array.wrap(events)
    @subscriptions = @subscriptions.filter (subscription) ->
      for event in events
        if event == subscription[0] && handler == subscription[1]
          return false
      return true
    this

  pub: (event, payload) ->
    for subscription in @subscriptions
      if event == subscription[0]
        subscription[1](event, payload)
    this

module.exports = Events
