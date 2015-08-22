React = require 'react'

module.exports =

  rerender: ->
    @forceUpdate()

  app: ->
    @context.app
