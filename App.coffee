require 'stdlibjs/Object.bindAll'

React                = require './React'
createFactory        = require './createFactory'
EventsPlugin         = require './EventsPlugin'
StorePlugin          = require './StorePlugin'
LocationPlugin       = require './LocationPlugin'
WindowSizePlugin     = require './WindowSizePlugin'
ResponsiveSizePlugin = require './ResponsiveSizePlugin'


class ReactatronApp

  constructor: (@config={}) ->
    @config.window ||= global.window

    Object.bindAll(this)
    @stats =
      storeGets: 0
      storeSets: 0
      storeChangeEvents: 0
      storeChangeRerenders: 0
      fullRerender: 0
      styledComponentRerenders: 0
      styleAssigns: 0

    EventsPlugin(this)
    StorePlugin(this)
    LocationPlugin(this)
    WindowSizePlugin(this)
    ResponsiveSizePlugin(this)

  getDOMNode: ->
    document.body

  MainComponent: -> React.DOM.div(null, 'you forgot to set app.MainComponent')

  render: ->
    @stats.fullRerender++
    console.info('App#render', @store.toObject())
    @rootComponent = React.render(
      RootComponent(app: this, Component: @MainComponent),
      @DOMNode = @getDOMNode()
    )

  start: ->
    if @rootComponent
      throw new Error('app already started')
    @pub 'start'
    @events.waitForClearQueue(@render)
    this

  stop: ->
    @DOMNode.innerHTML = ''
    delete @rootComponent
    delete @DOMNode
    @pub 'stop'
    this

module.exports = ReactatronApp



RootComponent = createFactory React.createClass
  displayName: 'ReactatronApp'

  propTypes:
    app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    Component: React.PropTypes.func.isRequired

  childContextTypes:
    app: React.PropTypes.instanceOf(ReactatronApp)

  getChildContext: ->
    app: @props.app

  render: ->
    console.info('ReactatronApp.RootComponent render')
    @props.Component()
