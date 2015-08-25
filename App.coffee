require 'stdlibjs/Object.bindAll'

React         = require 'react'
Events        = require './Events'
Store         = require './Store'
LocationPlugin = require('./LocationPlugin')
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
    # we will need this tobe responsive
    # @registerPlugin new WindowSize( window: options.window ) # :D

  registerPlugin: (plugin) ->
    plugin.app = this
    plugin.init() if plugin.init?
    @plugins.push plugin
    this

  getDOMNode: ->
    document.body

  render: ->
    @rootComponent = React.render(
      RootComponent(app: this, Component: @Component),
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
    @props.Component()
