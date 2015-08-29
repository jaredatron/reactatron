require 'stdlibjs/Object.type'
require 'stdlibjs/Array#excludes'

React = require 'react'
ReactatronApp = require './App'
Style = require './Style'

STYLE_PROPERTIES =
    grow:     'flexGrow'
    shrink:   'flexShrink'
    width:    'width'
    minWidth: 'minWidth'
    maxWidth: 'maxWidth'

arrayToObject = (array) ->
  object = {}
  object[key] = key for key in array
  object

parseDataBindings = (dataBindings) ->
  switch Object.type(dataBindings)
    when 'Undefined' then {}
    when 'Array'     then arrayToObject(dataBindings)
    when 'Function'  then parseDataBindings(dataBindings())
    when 'Object'    then dataBindings
    else throw new Error('invalid data bindings')


generateUUID = -> generateUUID.counter++
generateUUID.counter = 0

module.exports =

  contextTypes:
    # app: React.PropTypes.instanceOf(ReactatronApp).isRequired
    app: React.PropTypes.object.isRequired

  getInitialState: ->
    @_UUID ||= generateUUID()

    @app = @context.app || @props.app # || throw new Error('app not found')
    debugger unless @app?

    state = {}
    @_dataBindings = parseDataBindings(@dataBindings)
    for stateKey, storeKey of @_dataBindings
      state[stateKey] = @app.get(storeKey)
    state

  storeChange: (event, key) ->
    return unless @isMounted()
    @app.stats.storeChangeRerenders++
    for stateKey, storeKey of @_dataBindings
      if key == storeKey
        console.log('storeChange', this.constructor.displayName, stateKey, storeKey)
        @setState "#{stateKey}": @app.get(storeKey)

  componentWillMount: ->
    console.time('')
    for stateKey, storeKey of @_dataBindings
      @app.sub "store:change:#{storeKey}", @storeChange

  componentWillUnmount: ->
    for stateKey, storeKey of @_dataBindings
      @app.unsub "store:change:#{storeKey}", @storeChange

  rerender: ->
    return unless @isMounted()
    # console.count("rerender #{@constructor.displayName}")
    # console.info("rerender #{@constructor.displayName}", event, payload)
    @forceUpdate()

  ### DATA BINDINGS MIXIN ###


  componentWillUpdate: ->
    # console.log("componentWillUpdate", @_UUID, @constructor.displayName)
    # console.time("update #{@_UUID}")

  componentDidUpdate: ->
    # console.timeEnd("update #{@_UUID}")


  # get: (key) ->
  #   if @_dataBindings.excludes(key)
  #     @_dataBindings.push(key)

  #   @app.get(key)

  # componentWillUnmount: ->
  #   for key in @_dataBindings
  #     @app.unsub "store:change:#{key}", @storeChange

  # componentDidUpdate: ->
  #   for key in @_dataBindings
  #     @app.sub "store:change:#{key}", @storeChange


  # storeChange: (event, key) ->
  #   @app.stats.rerenders++
  #   @rerender()


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
