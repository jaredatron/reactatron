require 'stdlibjs/Object.bindAll'
assign = require 'object-assign'

location = @location || null

class Location

  location: location

  constructor: (events) ->
    Object.bindAll(this)
    @events = events
    @update()

  start: ->
    window.addEventListener 'popstate', @update

  stop: ->
    window.removeEventListener 'popstate', @update

  update: ->
    @path   = @location.pathname
    @params = searchToObject(@location.search)
    @events.emit('location:change')

  for: (path=@path, params=@params) ->
    path ||= ''
    path = '/'+path if path[0] != '/'
    "#{path}#{objectToSearch(params)}"


  set: (value, replace) ->
    value = "/#{value}" unless value[0] == '/'
    if replace
      history.replaceState({}, document.title, value)
    else
      history.pushState({}, document.title, value)
    @update()

  setPath: (path, replace) ->
    @set(@for(path), replace)

  setParams: (params, replace) ->
    @set(@for(null, params), replace)

  updateParams: (params, replace) ->
    @setParams(assign({}, @params, params), replace)


module.exports = Location

# private

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
