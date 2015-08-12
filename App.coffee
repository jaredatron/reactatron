React = require 'react'
BaseMixin = require './BaseMixin'
Location = require './Location'
RootComponent = require './RootComponent'
Router = require './Router'

# RootNode = require './RootNode'

class ReactatronApp
  constructor: ->
    @mixins = [BaseMixin]
    @location = new Location
    @RootComponent = RootComponent
    @router = new Router()

  component: (name, spec) ->
    if ('string' != typeof name)
      spec = name
      name = null
    spec ||= {}
    spec.displayName = name if name?
    spec.mixins ||= []
    spec.mixins = @mixins.concat(spec.mixins)
    component = React.createClass(spec)
    componentFactory = React.createFactory(component)
    componentFactory.component = component
    componentFactory.displayName = name if name?
    componentFactory


  getProps: ->
    route = @router.pageFor(@location.path, @location.params)
    path:         route.path
    params:       route.params
    page:         route.getComponent()
    locationFor:  @location.for
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
