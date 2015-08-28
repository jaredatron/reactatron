React = require 'react'
ReactatronApp = require './App'
Style = require './Style'
require 'stdlibjs/Array#excludes'

STYLE_PROPERTIES =
    grow:     'flexGrow'
    shrink:   'flexShrink'
    width:    'width'
    minWidth: 'minWidth'
    maxWidth: 'maxWidth'

module.exports =

  contextTypes:
    # app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    app: React.PropTypes.object.isRequired

  getInitialState: ->
    @_dataBindings = []
    @app = @context.app || @props.app # || throw new Error('app not found')
    debugger unless @app?
    {}

  rerender: ->
    return unless @isMounted()
    # console.count("rerender #{@constructor.displayName}")
    # console.info("rerender #{@constructor.displayName}", event, payload)
    @forceUpdate()

  ### DATA BINDINGS MIXIN ###

  get: (key) ->
    if @_dataBindings.excludes(key)
      @_dataBindings.push(key)
      @app.sub "store:change:#{key}", @storeChange

    @app.get(key)

  componentWillUnmount: ->
    for key in @_dataBindings
      @app.unsub "store:change:#{key}", @storeChange

  storeChange: (event, key) ->
    @app.stats.rerenders++
    @rerender()


  ### / DATA BINDINGS MIXIN ###


  ### STYLES MIXIN ###

  cloneProps: ->
    props = Object.clone(@props)

    # # TODO delete any props listed by PropTypes
    # debugger if this.constructor.displayName == 'DirectoryContents'
    # keys = Object.keys(this.propTypes||{})
    # delete props[key] for key in keys

    props.style = new Style(@defaultStyle)
      .merge(props.style)
      .merge(@styleFromProps())
      .merge(@enforcedStyle)
    props


  styleFromProps: ->
    style = {}
    for key, value of STYLE_PROPERTIES
      style[value] = @props[key] if @props[key]?
    style


  ### / STYLES MIXIN ###
