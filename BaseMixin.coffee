React = require 'react'

module.exports =

  rerender: ->
    @forceUpdate()

  getInitialState: ->
    poop: 45
