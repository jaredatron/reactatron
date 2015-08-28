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

  rerender: (event, payload) ->
    return unless @isMounted()
    console.count("rerender #{@constructor.displayName}")
    console.info("rerender #{@constructor.displayName}", event, payload)
    @forceUpdate()

  ### DATA BINDINGS MIXIN ###

  get: (key) ->
    if @_dataBindings.excludes(key)
      @_dataBindings.push(key)
      @app.sub "store:change:#{key}", @rerender

    @app.get(key)

  getInitialState: ->
    @_dataBindings = []
    @app = @context.app || @props.app # || throw new Error('app not found')
    debugger unless @app?
    {}

  componentWillUnmount: ->
    for key in @_dataBindings
      @app.unsub "store:change:#{key}", @rerender

  ### / DATA BINDINGS MIXIN ###


  ### STYLES MIXIN ###

  cloneProps: ->
    props = Object.clone(@props)
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
