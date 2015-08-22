class LocationPlugin

  window: global.window

  constructor: (app, options={}) ->
    Object.bindAll(this)
    @app = app
    @update()

  start: ->
    @window.addEventListener 'popstate', @update

  stop: ->
    @window.removeEventListener 'popstate', @update

  update: ->
    @app.set 'location', {
      path: @window.location.pathname
      params: searchToObject(@window.location.search)
    }

module.exports = LocationPlugin


searchToObject = (search) ->
  params = {}
  search = search.substring(search.indexOf('?') + 1, search.length);
  return {} if search.length == 0
  search.split(/&+/).forEach (param) ->
    [key, value] = param.split('=')
    key = decodeURIComponent(key)
    if value?
      value = decodeURIComponent(value)
    else
      value = true
    params[key] = value
  params
