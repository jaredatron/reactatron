require 'shouldhave/Object.bindAll'
require 'shouldhave/Object.assign'

React                = require './React'
createFactory        = require './createFactory'
EventsPlugin         = require './EventsPlugin'
StorePlugin          = require './StorePlugin'
LocationPlugin       = require './LocationPlugin'
WindowSizePlugin     = require './WindowSizePlugin'
ResponsiveSizePlugin = require './ResponsiveSizePlugin'

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

  constructor: (extension) ->
    Object.bindAll(this)
    Object.assign(this, extension)
    @window ||= global.window
    @stats ||= {}
    Object.assign(@stats, DEFAULT_STATS)
    EventsPlugin(this)
    StorePlugin(this)
    LocationPlugin(this)
    WindowSizePlugin(this)
    ResponsiveSizePlugin(this)

  getDOMNode: ->
    document.body

  start: ->
    console.group 'ReactatronApp#start'
    @pub 'start', null, =>
      console.log('rendering')
      @stats.fullRerender++
      @rootComponent = React.render(
        RootComponent(app: this, render: @render),
        @DOMNode = @getDOMNode()
      )
      console.groupEnd 'ReactatronApp#start'
      this

    this

  stop: ->
    @pub 'stop', null, =>
      @DOMNode.innerHTML = ''
      delete @rootComponent
      delete @DOMNode
    this

ReactatronApp




RootComponent = createFactory React.createClass
  displayName: 'ReactatronApp'

  propTypes:
    app:    React.PropTypes.instanceOf(ReactatronApp).isRequired
    render: React.PropTypes.func.isRequired

  childContextTypes:
    app: React.PropTypes.instanceOf(ReactatronApp)

  getChildContext: ->
    app: @props.app

  render: ->
    console.count('ReactatronApp render') # this should never happen twice
    if @props.render?
      @props.render()
    else
      React.DOM.div(null, 'you forgot to set app.render')
