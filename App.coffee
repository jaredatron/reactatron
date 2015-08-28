require 'stdlibjs/Object.bindAll'

React         = require 'react'
Events        = require './Events'
Store         = require './Store'
LocationPlugin = require('./LocationPlugin')
WindowSizePlugin = require('./WindowSizePlugin')
Router        = require './Router'

class ReactatronApp

  constructor: (options={}) ->
    options.window ||= global.window

    Object.bindAll(this)
    @plugins = []

    @events = new Events
    {@sub,@unsub,@pub} = @events

    @store = new Store(events: @events)
    {@get,@set,@del} = @store

    @registerPlugin new LocationPlugin( window: options.window )
    # we need this to be responsive
    @registerPlugin new WindowSizePlugin( window: options.window ) # :D

    @stats =
      rerenders: 0
      styledComponentRerenders: 0


  registerPlugin: (plugin) ->
    plugin.app = this
    plugin.init() if plugin.init?
    @plugins.push plugin
    this

  getDOMNode: ->
    document.body

  MainComponent: -> React.DOM.div(null, 'you forgot to set app.MainComponent')

  render: ->
    console.info('App#render', {store: @store.toObject()})
    @rootComponent = React.render(
      RootComponent(app: this, Component: @MainComponent),
      @DOMNode = @getDOMNode()
    )

  start: ->
    if @rootComponent
      throw new Error('app already started')
    @events.waitForClearQueue =>
      console.info('App#start')
      @plugins.forEach (plugin) -> plugin.start()
      # console.log('pub app start')
      # @pub 'app start', this
      @render()
    this

  stop: ->
    # @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @pub 'app stop', this
    @plugins.forEach (plugin) -> plugin.stop()
    this

module.exports = ReactatronApp



RootComponent = React.createFactory React.createClass
  displayName: 'ReactatronApp'

  propTypes:
    app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    Component: React.PropTypes.func.isRequired

  childContextTypes:
    app: React.PropTypes.instanceOf(ReactatronApp)

  getChildContext: ->
    app: @props.app

  render: ->
    @props.app.pub 'ReactatronApp.RootComponent render'
    @props.Component()
