Location = require './Location'

module.exports = (app) ->

  window = app.config.window

  app.location = new Location window: window
  Object.assign(app, mixin)

  update = ->
    app.location.update()
    app.updateLocation()


  app.sub 'start', ->
    update()
    window.addEventListener 'popstate', update

  app.sub 'stop', ->
    window.removeEventListener 'popstate', update


mixin =
  locationFor: (path, params) ->
    @location.for(path, params)

  updateLocation: ->
    console.trace('updateLocation')
    @set location:
      path:   @location.path
      params: @location.params
    @app

  setLocation: (path, replace) ->
    @location.set(path, replace)
    @updateLocation()

  setPath: (params, replace) ->
    @location.setPath(params, replace)
    @updateLocation()

  setParams: (params, replace) ->
    @location.setParams(params, replace)
    @updateLocation()

  clearHash: ->
    @location.clearHash()
    @updateLocation()
