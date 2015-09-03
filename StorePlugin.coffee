Store = require './Store'

module.exports = (app) ->

  app.store = new Store
    events: app.events
    data:   app.window.localStorage
  app.get = app.store.get
  app.set = app.store.set
  app.del = app.store.del
