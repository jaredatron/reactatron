Store = require './Store'

module.exports = (app) ->

  app.store = new Store events: app.events
  app.get = app.store.get
  app.set = app.store.set
  app.del = app.store.del
