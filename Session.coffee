require 'stdlibjs/Object.assign'
EventEmitter = require 'eventemitter3'

PREFIX = "TORFLIX/"

class Session

  localStorage: localStorage

  get: (key) ->
    throw new Error('key cannot be blank') if !key?
    value = @localStorage["#{PREFIX}#{key}"]
    return if value? then JSON.parse(value) else null

  set: (key, value) ->
    throw new Error('key cannot be blank') if !key?
    if value == null
      delete @localStorage["#{PREFIX}#{key}"]
      setTimeout ->
        App.session.emit('change')
        App.session.emit("change:#{key}", null)
    else
      json = JSON.stringify(value)
      value = JSON.parse(json)
      if @localStorage["#{PREFIX}#{key}"] != json
        @localStorage["#{PREFIX}#{key}"] = json
        setTimeout ->
          App.session.emit('change')
          App.session.emit("change:#{key}", value)
    value




module.exports = Session
