require 'stdlibjs/Object.isObject'
require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array#remove'
require 'stdlibjs/Array#filter'
require 'stdlibjs/String#startsWith'

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

  constructor: ({@events, @app}) ->
    Object.bindAll(this)
    @subscriptions = {}
    @changedKeys = {}
    @stats =
      totalGets: 0
      totalSets: 0
      gets: {}
      sets: {}

    # # disable localStorage
    # @data = {}
    # # disable JSON serialization
    # @_serialize = (object) -> object
    # @_deserialize = (object) -> object

  prefix: 'Reactatron/'

  _serialize: (object) ->
    JSON.stringify(object)

  _deserialize: (object) ->
    JSON.parse(object)

  #
  # @private
  #
  #
  _get: (key) ->
    @stats.totalGets++
    @stats.gets[key] = (@stats.gets[key]||0) + 1
    key = "#{@prefix}#{key}"
    value = @_deserialize(@data[key]) if key of @data
    value


  #
  # @private
  #
  #
  _set: (changes) ->
    @stats.totalSets++
    @stats.sets[key] = (@stats.sets[key]||0) + 1
    for key, value of changes
      if value == undefined
        delete @data["#{@prefix}#{key}"]
      else
        @data["#{@prefix}#{key}"] = @_serialize(value)
      @events.pub("store:change:#{key}", key)

  #
  # @example
  #
  #   store.get ['a','b']
  #
  get: (keys) ->
    if isArray(keys)
      keys.map(@_get)
    else
      @_get(keys)


  #
  # @example
  #
  #   store.set a:1, b:2
  #
  set: (changes) ->
    throw new Error("Store#set first arg must be an object") unless Object.isObject(changes)
    # console.trace("Store#set", changes)
    @_set(changes)
    this

  #
  # @example
  #
  #   store.del ['a', 'b']

  #
  del: (keys) ->
    keys = toArray(keys)
    changes = {}
    changes[key] = undefined for key in keys
    @set(changes)
    this

  keys: ->
    keys = []
    Object.keys(@data).forEach (key) =>
      if key.startsWith(@prefix)
        keys.push key.slice(@prefix.length)
    keys

  clear: ->
    @del @keys()
    this

  toObject: ->
    object = {}
    console.groupCollapsed 'Store#toObject'
    for key in @keys()
      object[key] = @get(key)
    console.groupEnd 'Store#toObject'
    object






