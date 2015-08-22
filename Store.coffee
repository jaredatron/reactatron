require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array#remove'

isArray = require 'stdlibjs/isArray'

localStorage = @localStorage || {}

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

  constructor: (options={}) ->
    Object.bindAll(this)
    @data = options.data || localStorage
    @subscriptions = {}

  #
  # @private
  #
  #
  _get: (key) ->
    JSON.parse(@data[key]) if key of @data

  #
  # @private
  #
  #
  _set: (key, value) ->
    @data[key] = JSON.stringify(value)
    @_emit(key)

  #
  # @private
  #
  #
  _unset: (key) ->
    delete @data[key]

  #
  # @private
  #
  #
  _emit: (key) ->
    handlers = @subscriptions[key] || []
    for handler in handlers
      handler(key)



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
  unset: (keys) ->
    @_unset(key) for key in toArray(keys)

  #
  # @example
  #
  #   handler = (key, value) ->
  #     console.log(key, value)
  #
  #   store.sub ['a', 'b'], handler
  #
  sub: (keys, handler) ->
    for key in toArray(keys)
      handlers = @subscriptions[key] ||= []
      handlers.push(handler)
    this

  #
  # @example
  #
  #   store.unsub ['a', 'b'], handler
  #
  unsub: (keys, handler) ->
    for key in toArray(keys)
      handlers = @subscriptions[key] ||= []
      handlers.remove(handler)
    this







