React = require 'react'
ReactatronApp = require './App'
require 'stdlibjs/Array#excludes'

module.exports =

  contextTypes:
    # app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    app: React.PropTypes.object.isRequired

  rerender: ->
    @forceUpdate()

  ### DATA BINDINGS MIXIN ###

  get: (key) ->
    if @_dataBindings.excludes(key)
      @_dataBindings.push(key)
      @app.sub "store:change:#{key}", @rerender

    @app.get(key)

  getInitialState: ->
    @_dataBindings = []
    @app = @context.app || @props.app

  componentWillUnmount: ->
    for key in @_dataBindings
      @app.unsub "store:change:#{key}", @rerender

  ### / DATA BINDINGS MIXIN ###


  ### STYLES MIXIN ###

  cloneProps: ->
    props = Object.clone(@props)
    props.style = Object.assign(
      {},
      @defaultStyle || {},
      @props.style || {},
      @enforcedStyle || {},
    )
    props

  ### / STYLES MIXIN ###
