class LocationPlugin

  window: global.window

  init: ->
    Object.bindAll(this)
    @app.locationFor = @for
    @app.setLocation = @set
    @app.setPath = @setPath
    @app.setParams = @setParams
    @update()

  start: ->
    @window.addEventListener 'popstate', @update
    @app

  stop: ->
    @window.removeEventListener 'popstate', @update
    @app

  update: ->
    @app.set 'location', {
      path:   @window.location.pathname
      params: searchToObject(@window.location.search)
    }
    @app

  for: (path, params) ->
    location = @app.get('location')
    path ||= location.path
    params ||= location.params
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
