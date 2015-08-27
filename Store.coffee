require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array#remove'
require 'stdlibjs/Array#filter'

isArray = require 'stdlibjs/isArray'



toArray = (object) ->
  if isArray(object) then object else [object]


#
# @example
#
#   store = new Store
#
#   store = new Store data: {}
#
module.exports = class Store

  data: global.localStorage || {}

  constructor: (options={}) ->
    Object.bindAll(this)
    @events = options.events
    @subscriptions = {}

  prefix: 'Reactatron/'

  #
  # @private
  #
  #
  _get: (key) ->
    key = "#{@prefix}#{key}"
    JSON.parse(@data[key]) if key of @data

  #
  # @private
  #
  #
  _set: (key, value) ->
    @data["#{@prefix}#{key}"] = JSON.stringify(value)
    @events.pub("store:change:#{key}", {type:'set'})


  #
  # @private
  #
  #
  _unset: (key) ->
    delete @data["#{@prefix}#{key}"]
    @events.pub("store:change:#{key}", {type:'del'})


  #
  # @example
  #
  #   store.get ['a','b']
  #
  get: (keys) ->
    if isArray(keys)
      keys.map (key) -> @_get(key)
    else
      @_get(keys)


  #
  # @example
  #
  #   store.set a:1, b:2
  #
  set: (pairs) ->
    if arguments.length == 2
      @_set(arguments[0], arguments[1])
    else
      for key, value of pairs
        @_set(key, value)
    this

  #
  # @example
  #
  #   store.unset ['a', 'b']

  #
  del: (keys) ->
    @_unset(key) for key in toArray(keys)
    this

  keys: ->
    keys = []
    Object.keys(@data).forEach (key) =>
      if key.startsWith(@prefix)
        keys.push key.slice(@prefix.length)
    keys

  clear: ->
    Object.keys(@data).forEach (key) =>
      if key.startsWith(@prefix)
        delete @data[key]
    this







