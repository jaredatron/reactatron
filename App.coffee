React = require 'react'
Location = require './Location'

# RootNode = require './RootNode'

class ReactatronApp
  constructor: (options) ->
    @location = new Location
    Object.assign(this, options)

  getProps: ->
    path:   @location.path
    params: @location.params

  start: ->
    if @rootComponent
      throw new Error('already started', this)
    window.addEventListener 'popstate', @location.update
    @DOMNode ||= document.body
    @rootComponent = @RootComponent(@getProps())
    React.render(@rootComponent, @DOMNode)

    this


  stop: ->
    @DOMNode.innerHTML = ''
    delete @rootComponent
    window.removeEventListener 'popstate', @location.update
    this

module.exports = ReactatronApp