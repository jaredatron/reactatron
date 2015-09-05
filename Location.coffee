require 'shouldhave/Object.bindAll'
searchToObject = require './searchToObject'
locationToString = require './locationToString'

module.exports = class Location

  constructor: ({@window}) ->
    Object.bindAll(this)
    @update()

  update: ->
    @path   = @window.location.pathname
    @params = searchToObject(@window.location.search)
    this

  for: (path=@path, params=@params) ->
    path = ensureSlashPrefix(path)
    locationToString { path, params }

  set: (value, replace) ->
    if 'object' == typeof value
      {path, params} = value
      value = @for(path, params)

    if value == @for()
      console.warn('SAME LOCATION', value)
      return false

    value = ensureSlashPrefix(value)

    if replace
      @window.history.replaceState({}, @window.document.title, value)
    else
      @window.history.pushState({}, @window.document.title, value)
    @update()

  setPath: (path, replace) ->
    @set(@for(path), replace)

  setParams: (params, replace) ->
    @set(@for(null, params), replace)

  updateParams: (params, replace) ->
    @setParams(assign({}, @params, params), replace)

  clearHash: ->
    @set(@for(), true)



ensureSlashPrefix = (string) ->
  if string[0] == '/'
    string
  else
    "/#{string}"


