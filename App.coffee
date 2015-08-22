require 'stdlibjs/Object.bindAll'

React = require 'react'

class ReactatronApp

  document: global.document
  location: global.location


  Events:        require './Events'
  Store:         require './Store'
  Location:      require './Location'
  RootComponent: require './RootComponent'
  Router:        require './Router'

  constructor: (options={}) ->
    # Object.bindAll(this)
    Object.assign(this, options)

    @document = options.document if 'document' of options
    @location =


    @events = new @Events
    {@sub,@unsub,@pub} = @events
    @store = new @Store(@events, options.storeData)
    {@get,@set,@del} = @store

    @router = new @Router

    @plugins = []

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
    @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @plugins.forEach (plugin) -> plugin.start()
    this

module.exports = ReactatronApp

