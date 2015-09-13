searchToObject = require './searchToObject'
objectToSearch = require './objectToSearch'

module.exports = (app) ->

  return if app.locationFor

  window = app.window

  update = ->
    app.path   = app.window.location.pathname
    app.params = searchToObject(app.window.location.search)
    app.pub 'location:change'

  update()

  app.sub 'start', ->
    window.addEventListener 'popstate', update

  app.sub 'stop', ->
    window.removeEventListener 'popstate', update

  app.locationToString = ({path, params}) ->
    path = "/#{path}" unless path[0] == '/'
    params ||= {}
    "#{path}#{objectToSearch(params)}"

  app.locationFor = ({path, params}) ->
    path   = @path   unless path?
    params = @params unless params?
    {path, params}

  app.setLocation = ({path, params, replace}) ->
    currentLocation =
      path:   app.path
      params: app.params
    value = app.locationToString({path, params})
    if value == app.locationToString(currentLocation)
      return currentLocation

    if replace
      window.history.replaceState({}, window.document.title, value)
    else
      window.history.pushState({}, window.document.title, value)
    update()
    location

  app.setPath = (path, replace) ->
    app.setLocation(path: path, params: @params, replace: replace)

  app.setParams = (params, replace) ->
    app.setLocation(path: @path, params: params, replace: replace)

  app.updateParams = (params, replace) ->
    app.setParams(Object.assign({}, app.params, params), replace)

  app.clearHash = ->
    app.setLocation(app.locationFor({}), true)
