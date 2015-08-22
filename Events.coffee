require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array.wrap'
require 'stdlibjs/Array#remove'
isString = require 'stdlibjs/isString'

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
        if event.toString() == subscription[0].toString() && handler == subscription[1]
          return false
      return true
    this

  pub: (event, payload) ->
    for subscription in @subscriptions
      [eventExpression, handler] = subscription

      if (
          (isString(eventExpression) && event == eventExpression) ||
          (eventExpression instanceof RegExp && eventExpression.test(event))
        )
        handler(event, payload)

    this

module.exports = Events
