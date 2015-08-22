require 'stdlibjs/Object.bindAll'

Events = require './Events'
Store = require './Store'
# Location = require './Location'
RootComponent = require './RootComponent'
Router = require './Router'
# Session = require './Session'

class ReactatronApp

  RootComponent: RootComponent

  constructor: (options={}) ->
    # Object.bindAll(this)
    @events = new Events
    {@sub,@unsub,@pub} = @events
    @store = new Store(@events, options.storeData)
    {@get,@set,@del} = @store

    # @router = new Router

    # @location = new Location(@events)
    # @session = new Session(@events)

    # @on('location:change', @rerender)

  state: {}
  setState: (newState) ->
    Object.assign(@state, newState)


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
    if !@rootComponent? then return
    @rootComponent.setProps(@state)

  getDOMNode: ->
    document.body

  start: ->
    if @rootComponent
      throw new Error('already started', this)
    @location.start()
    @rootComponent = React.render(
      @RootComponent(@state),
      @DOMNode = @getDOMNode()
    )
    this


  stop: ->
    @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @location.stop()
    this

module.exports = ReactatronApp
