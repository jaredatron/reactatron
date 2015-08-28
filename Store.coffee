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

  constructor: (options={}) ->
    Object.bindAll(this)
    @events = options.events
    @subscriptions = {}
    @changedKeys = {}

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
  _set: (changes) ->
    # console.count('Store#set')
    for key, value of changes
      if value == undefined
        delete @data["#{@prefix}#{key}"]
      else
        @data["#{@prefix}#{key}"] = JSON.stringify(value)
      @events.pub("store:change:#{key}", key)

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
  set: (changes) ->
    throw new Error("Store#set first arg must be an object") unless Object.isObject(changes)
    console.trace("Store#set", changes)
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
    for key in @keys()
      object[key] = @get(key)
    object






