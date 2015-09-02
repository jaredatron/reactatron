Events = require './Events'

module.exports = (app) ->

  app.events = new Events
  app.sub    = app.events.sub
  app.unsub  = app.events.unsub
  app.pub    = app.events.pub
  app.onNext = app.events.onNext
