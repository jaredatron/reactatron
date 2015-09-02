require 'stdlibjs/Object.bindAll'

module.exports = class Location

  constructor: ({@window}) ->
    Object.bindAll(this)

  update: ->
    @path   = @window.location.pathname
    @params = searchToObject(@window.location.search)
    this

  for: (path=@path, params=@params) ->
    @path
    path = ensureSlashPrefix(path)
    "#{path}#{objectToSearch(params)}"

  set: (value, replace) ->
    if 'object' == typeof value
      {path, params} = value
      value = @for(path, params)

    value = ensureSlashPrefix(value)

    if replace
      history.replaceState({}, document.title, value)
    else
      history.pushState({}, document.title, value)

    @update()
    @this

  setPath: (path, replace) ->
    @set(@for(path), replace)

  setParams: (params, replace) ->
    @set(@for(null, params), replace)

  updateParams: (params, replace) ->
    @setParams(assign({}, @params, params), replace)

  clearHash: ->
    @update() unless @path && @params
    @set(@for(), true)



ensureSlashPrefix = (string) ->
  if string[0] == '/'
    string
  else
    "/#{string}"



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
