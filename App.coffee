require 'stdlibjs/Object.bindAll'

React         = require 'react'
Events        = require './Events'
Store         = require './Store'
RootComponent = require './RootComponent'
LocationPlugin = require('./LocationPlugin')
Router        = require './Router'

class ReactatronApp

  document: global.document

  constructor: ->
    Object.bindAll(this)
    @plugins = []

    @events = new Events
    {@sub,@unsub,@pub} = @events

    @store = new Store(@events)
    {@get,@set,@del} = @store

    @registerPlugin new LocationPlugin({})

    @router = new Router(this)


  registerPlugin: (plugin) ->
    plugin.app = this
    plugin.init() if plugin.init?
    @plugins.push plugin
    this

    # @location = new Location(this)

  # getProps: ->
  #   route = @router.pageFor(@location.path, @location.params)
  #   path:         route.path
  #   params:       route.params
  #   page:         route.getPage()
  #   locationFor:  @location.for
  #   setLocation:  @location.set

  #   setPath:      @location.setPath
  #   setParams:    @location.setParams
  #   updateParams: @location.updateParams

  getDOMNode: ->
    @document.body

  RootComponent: RootComponent
  render: ->
    @rootComponent = React.render(
      @RootComponent(app: this),
      @DOMNode = @getDOMNode()
    )

  start: ->
    if @rootComponent
      throw new Error('already started', this)
    @plugins.forEach (plugin) -> plugin.start()
    @render()
    this

  stop: ->
    # @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @plugins.forEach (plugin) -> plugin.stop()
    this

module.exports = ReactatronApp

