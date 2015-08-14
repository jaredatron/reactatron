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
    page:         route.page
    locationFor:  @location.for
    setLocation:  @location.set
    setPath:      @location.setPath
    setParams:    @location.setParams
    updateParams: @location.updateParams

  rerender: ->
    console.info('rerender')
    @rootComponent.setProps(@getProps())

  start: ->
    if @rootComponent
      throw new Error('already started', this)
    window.addEventListener 'popstate', @location.update
    @DOMNode ||= document.body
    @rootComponent = React.render(
      @RootComponent(@getProps()),
      @DOMNode
    )

    @location.on('change', @rerender)

    this


  stop: ->
    @DOMNode.innerHTML = ''
    delete @rootComponent
    window.removeEventListener 'popstate', @location.update
    this

module.exports = ReactatronApp
