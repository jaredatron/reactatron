require 'stdlibjs/Object.bindAll'
EventEmitter = require 'eventemitter3'

class Events extends EventEmitter
  constructor: ->
    Object.bindAll(this)


module.exports = Events
