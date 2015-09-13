require 'shouldhave/Object.bindAll'
require 'shouldhave/Object.assign'

React                = require './React'
createFactory        = require './createFactory'
EventsPlugin         = require './EventsPlugin'
StorePlugin          = require './StorePlugin'
RouterPlugin         = require './RouterPlugin'
# LocationPlugin       = require './LocationPlugin'
# WindowSizePlugin     = require './WindowSizePlugin'
# ResponsiveSizePlugin = require './ResponsiveSizePlugin'

DEFAULT_STATS =
  storeGets: 0
  storeSets: 0
  storeChangeEvents: 0
  storeChangeRerenders: 0
  fullRerender: 0
  styledComponentRerenders: 0
  styleAssigns: 0
  componentsInitialized: 0
  componentsMounted: 0
  componentsUpdated: 0
  componentsUnmounted: 0

module.exports = class ReactatronApp

  constructor: (@config) ->
    Object.bindAll(this)
    @window = @config.window || global.window
    @stats = Object.assign({}, DEFAULT_STATS, @config.stats||{})
    EventsPlugin(this)
    StorePlugin(this)
    RouterPlugin(this) if @config.routes?
    # ResponsivePlugin(this) if @config.responsive?


  start: ->
    console.group 'ReactatronApp#start'
    throw new Error('already started') if @DOMNode?
    @pub 'start', null, =>
      console.log('rendering')
      @stats.fullRerender++
      @DOMNode = @config.DOMNode || @window.document.body
      @_rootCompnentInstance = RootComponent(app: this)
      @rootComponent = React.render(@_rootCompnentInstance, @DOMNode)
      console.groupEnd 'ReactatronApp#start'
      this

    this

  stop: ->
    @pub 'stop', null, =>
      @DOMNode.innerHTML = ''
      delete @rootComponent
      delete @DOMNode
    this

  render: ->

ReactatronApp




RootComponent = createFactory React.createClass
  displayName: 'ReactatronApp'

  propTypes:
    app:    React.PropTypes.instanceOf(ReactatronApp).isRequired

  childContextTypes:
    app: React.PropTypes.instanceOf(ReactatronApp)

  getChildContext: ->
    app: @props.app

  componentDidMount: ->
    @props.app.sub('route:change', @routeChanged)

  componentWillUnmount: ->
    @props.app.unsub('route:change', @routeChanged)

  routeChanged: (event, route) ->
    if route.isARedirect
      @props.app.setLocation(route.location)
    else
      @forceUpdate()

  render: ->
    route = @props.app.route
    switch
      when !route?
        React.DOM.div {}, 'route undefined :('
      when route.component?
        route.component(route.params)
      else
        React.DOM.div {}, 'route component not found :('


