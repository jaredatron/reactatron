searchToObject = require './searchToObject'
objectToSearch = require './objectToSearch'
Location = require './Location'

module.exports = (app) ->

  window = app.config.window

  app.location = new Location window: window
  Object.assign(app, mixin)

  update = ->
    app.location.update()
    app.updateLocation()

  onPopstate = ->
    x =
      path:   currentPath()
      params: currentParams()
    console.log('POPSTATE', x)

  onLocationChange = ->
    location = currentLocation()
    newLocation = app.get('location')
    console.log("onLocationChange from: #{locationToString(location)} to: #{locationToString(newLocation)}")
    return if equalLocations(location, newLocation)
    console.log("CHANGING!! from: #{locationToString(location)} to: #{locationToString(newLocation)}")
    app.location.set(newLocation, true)



  app.sub 'start', ->
    update()
    window.addEventListener 'popstate', onPopstate
    app.sub 'store:change:location', onLocationChange

  app.sub 'stop', ->
    window.removeEventListener 'popstate', update
    app.unsub 'store:change:location', onLocationChange





  currentPath = ->
    window.location.pathname
  currentSearch = ->
    window.location.search
  currentParams = ->
    searchToObject(currentSearch())
  currentLocation = ->
    path: currentPath()
    params: currentParams()


equalLocations = (a, b) ->
  locationToString(a) == locationToString(b)

locationToString = ({path, params}) ->
  "#{path}#{objectToSearch(params)}"





mixin =
  locationFor: (path, params) ->
    @location.for(path, params)

  updateLocation: ->
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
