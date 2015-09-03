require 'stdlibjs/Object.bindAll'
searchToObject = require './searchToObject'
objectToSearch = require './objectToSearch'

module.exports = class Location

  constructor: ({@window}) ->
    Object.bindAll(this)
    @update()

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


