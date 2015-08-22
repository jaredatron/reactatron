require 'stdlibjs/Object.bindAll'
require 'stdlibjs/Array#remove'
isArray = require 'stdlibjs/isArray'

localStorage = @localStorage || {}

module.exports = class Store

  constructor: (options={}) ->
    Object.bindAll(this)
    @data = options.data || localStorage
    @subscriptions = {}

  get: (keys) ->
    if isArray(keys)
      results = {}
      for key, index in keys
        result = @data[key]
        results[index] = results[key] = Store.get(@data, key)
      results
    else
      Store.get(@data, keys)


  set: (key, value) ->
    if arguments.length == 2
      Store.set(@data, key, value)
    else
      for k, v of key
        Store.set(@data, k, v)
    this

  unset: (keys) ->
    Store.unset(@data, key) for key in KEYS(keys)

  sub: (keys, handler) ->
    for key in KEYS(keys)
      handlers = @subscriptions[key] ||= []
      handlers.push(handler)
    this


  unsub: (keys, handler) ->
    for key in KEYS(keys)
      handlers = @subscriptions[key] ||= []
      handlers.remove()
    this



KEYS = (keys) ->
  if isArray(keys) then keys else [keys]



Store.get = (data, key) ->
  JSON.parse(data[key]) if key of data

Store.set = (data, key, value) ->
  data[key] = JSON.stringify(value)

Store.unset = (data, key) ->
  delete data[key]
