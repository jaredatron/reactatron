require 'stdlibjs/Object.bindAll'
React = require 'react'
BaseMixin = require './BaseMixin'
Location = require './Location'
RootComponent = require './RootComponent'
Router = require './Router'

class ReactatronApp
  constructor: ->
    Object.bindAll(this)
    @location = new Location
    @RootComponent = RootComponent
    @router = new Router()

  getProps: ->
    route = @router.pageFor(@location.path, @location.params)
    path:         route.path
    params:       route.params
    page:         route.getPage()
    locationFor:  @location.for
    setLocation:  @location.set
    setPath:      @location.setPath
    setParams:    @location.setParams
    updateParams: @location.updateParams

  rerender: ->
    console.info('rerender')
    @rootComponent.setProps(@getProps())

  getDOMNode: ->
    document.body

  start: ->
    if @rootComponent
      throw new Error('already started', this)
    window.addEventListener 'popstate', @location.update
    @rootComponent = React.render(
      @RootComponent(@getProps()),
      @DOMNode = @getDOMNode()
    )
    @location.on('change', @rerender)
    this


  stop: ->
    @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @location.off('change', @rerender)
    window.removeEventListener 'popstate', @location.update
    this

module.exports = ReactatronApp
