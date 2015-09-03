Location = require './Location'

module.exports = (app) ->

  window = app.window

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
    @set location:
      path:   @location.path
      params: @location.params
    @app

  setLocation: (path, replace) ->
    @updateLocation() if @location.set(path, replace)

  setPath: (params, replace) ->
    @updateLocation() if @location.setPath(params, replace)

  setParams: (params, replace) ->
    @updateLocation() if @location.setParams(params, replace)

  clearHash: ->
    @location.clearHash()
    this
