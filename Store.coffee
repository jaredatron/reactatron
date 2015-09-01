require 'stdlibjs/Object.fromTwoArrays'
require 'stdlibjs/Object.isObject'
require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array#remove'
require 'stdlibjs/Array#filter'
require 'stdlibjs/String#startsWith'

delay = require 'stdlibjs/delay'
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

  constructor: ({@events, @app, @prefix}) ->
    Object.bindAll(this)
    @prefix ||= "Reactatron/"
    @subscriptions = {}
    @stats =
      totalGets: 0
      totalSets: 0
      gets: {}
      sets: {}

    @_loadExpires()

    # # disable localStorage
    # @data = {}
    # # disable JSON serialization
    # @_serialize = (object) -> object
    # @_deserialize = (object) -> object


  ###*
  #
  # @private
  #
  ###
  _now: ->
    Date.now()


  _serialize: (object) ->
    JSON.stringify(object)


  _deserialize: (object) ->
    JSON.parse(object)


  __get: (key) ->
    storeKey = "#{@prefix}#{key}"
    @_deserialize(@data[storeKey]) if storeKey of @data


  __set: (key, value) ->
    if value == undefined
      @__del(key)
    else
      @data["#{@prefix}#{key}"] = @_serialize(value)


  __del: (key) ->
    delete @data["#{@prefix}#{key}"]



  #
  # @private
  #
  #
  _get: (key) ->
    @stats.totalGets++
    @stats.gets[key] = (@stats.gets[key]||0) + 1
    result = @__get(key)
    if result
      result[1]
    else
      undefined


  #
  # @private
  #
  #
  _set: (changes) ->
    @stats.totalSets++
    @stats.sets[key] = (@stats.sets[key]||0) + 1
    for key, value of changes
      value = [@_now(), value] unless value == undefined
      @__set(key, value)
      @events.pub("store:change:#{key}", key)







  _loadExpires: ->
    @_expires = @__get('_expires') || {}
    now = @_now()
    for key, expiresAt of @_expires
      delta = expiresAt - now
      if delta <= 0
        @__del(key)
        delete @_expires[key]
      else
        @_scheduleExpiration(key, delta)
    @_saveExpires();

  _saveExpires: ->
    @__set('_expires', @_expires)



  _scheduleExpiration: (key, delayFor) ->
    delay delayFor, =>
      expiresAt = @_expires[key]
      return unless expiresAt?
      entry = @__get(key)
      return unless entry?
      [setAt, value] = entry
      if !setAt? || setAt <= expiresAt
        @del(key)
        delete @_expires[key]


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

  ###*
  # Store#expire
  # http://redis.io/commands/expire
  #
  # @param {Object} key value pairs where the value is an Time integer
  # @return {this}
  #
  ###
  expire: (expires) ->
    now = @_now()
    exipreNow = []
    for key, expiresAt of expires
      if expiresAt <= now
        exipreNow.push key
      else
        @_expires[key] = expiresAt
        @_scheduleExpiration(key, expiresAt - now)
    @del(exipreNow)
    this


  #   for key in
  #     if key less than now
  #       epire now (includes expire events)
  #     else
  #       scheudle setTimeout to expire
  #       on boot we do this too to avoid having a watcher

  #   @_expires(keys)
  #   @_scheduleExpiration()
  #   this

  # _expires: (expires) ->
  #   key = "#{@prefix}_expires"
  #   if arguments.length == 0
  #     return @__expires ||= if key of @data then @_deserialize(@data[key]) else {}
  #   @data[key] = @_serialize Object.assign(@_expires(), expires)

  # _scheduleExpiration: ->
  #   @_scheduleExpirationTimeout ||= setTimeout(@_expireKeys)
  #   this

  # _expireKeys: ->
  #   delete @_scheduleExpirationTimeout
  #   now = @_now()
  #   keysToDelete = []
  #   for key, expiresAt of @_expires()
  #     keysToDelete.push(key) if expiresAt <= now
  #   console.log('expiring keys', keysToDelete, now, @_expires())
  #   @del(keysToDelete)


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
    keys = @keys()
    console.groupCollapsed 'Store#toObject'
    object = Object.fromTwoArrays(keys, @get(keys))
    console.groupEnd 'Store#toObject'
    object






