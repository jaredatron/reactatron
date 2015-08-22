Router = require '../Router'

describe 'Router', ->

  router = null
  beforeEach ->
    storeData = {}
    router = new Router(events)
