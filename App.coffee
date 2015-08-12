React = require 'react'
BaseMixin = require './BaseMixin'
Location = require './Location'
RootComponent = require './RootComponent'
Router = require './Router'

# RootNode = require './RootNode'

class ReactatronApp
  constructor: ->
    @location = new Location
    @RootComponent = RootComponent
    @router = new Router()

  getProps: ->
    route = @router.pageFor(@location.path, @location.params)
    path:         route.path
    params:       route.params
    page:         route.getComponent()
    locationFor:  @location.for
    setLocation:  @location.set
    setPath:      @location.setPath
    setParams:    @location.setParams
    updateParams: @location.updateParams

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
