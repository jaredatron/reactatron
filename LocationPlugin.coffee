require 'stdlibjs/Object.bindAll'

module.exports = class LocationPlugin

  constructor: (options) ->
    Object.bindAll(this)
    @window = options.window

  init: ->
    @app.locationFor = @for
    @app.setLocation = @set
    @app.setPath = @setPath
    @app.setParams = @setParams
    @app.clearHash = @clearHash

  start: ->
    @update()
    @window.addEventListener 'popstate', @update
    # @app.sub 'store:change:location', @update

  stop: ->
    @window.removeEventListener 'popstate', @update
    # @app.unsub 'store:change:location', @update

  readLocation: ->
    path:   @window.location.pathname
    params: searchToObject(@window.location.search)

  update: ->
    @location = @readLocation()
    @app.set location: @location
    @app

  for: (path, params) ->
    path ||= @location.path
    params ||= @location.params
    path = '/'+path if path[0] != '/'
    "#{path}#{objectToSearch(params)}"

  set: (value, replace) ->
    value = "/#{value}" unless value[0] == '/'
    if replace
      history.replaceState({}, document.title, value)
    else
      history.pushState({}, document.title, value)
    @update()
    @app

  setPath: (path, replace) ->
    @set(@for(path), replace)
    @app

  setParams: (params, replace) ->
    @set(@for(null, params), replace)
    @app

  updateParams: (params, replace) ->
    @setParams(assign({}, @params, params), replace)
    @app

  clearHash: ->
    @location ||= @readLocation()
    @set(@for(@location.path, @location.params))





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


objectToQueryString = (params) ->
  return undefined if !params?
  pairs = []
  Object.keys(params).forEach (key) ->
    value = params[key]
    switch value
      when true
        pairs.push "#{encodeURIComponent(key)}"
      when false, null, undefined
      else
        pairs.push "#{encodeURIComponent(key)}=#{encodeURIComponent(value)}"
  pairs.join('&')

objectToSearch = (params) ->
  search = objectToQueryString(params)
  if search.length == 0 then '' else '?'+search
