module.exports =
  _: null


# require 'stdlibjs/Object.type'
# require 'stdlibjs/Array#excludes'

# React = require 'react'
# ReactatronApp = require './App'
# Style = require './Style'

# STYLE_PROPERTIES =
#     grow:     'flexGrow'
#     shrink:   'flexShrink'
#     width:    'width'
#     minWidth: 'minWidth'
#     maxWidth: 'maxWidth'

# arrayToObject = (array) ->
#   object = {}
#   object[key] = key for key in array
#   object

# parseDataBindings = (dataBindings) ->
#   switch Object.type(dataBindings)
#     when 'Undefined' then {}
#     when 'Array'     then arrayToObject(dataBindings)
#     when 'Function'  then parseDataBindings(dataBindings())
#     when 'Object'    then dataBindings
#     else throw new Error('invalid data bindings')


# generateUUID = -> generateUUID.counter++
# generateUUID.counter = 0

# module.exports =

#   contextTypes:
#     # app: React.PropTypes.instanceOf(ReactatronApp).isRequired
#     app: React.PropTypes.object.isRequired

#   getInitialState: ->
#     @_UUID ||= generateUUID()

#     @app = @context.app || @props.app # || throw new Error('app not found')
#     debugger unless @app?

#     @parseDataBindings()
#     @getData()

#   componentWillMount: ->
#     @subscribeToStoreChanges()

#   componentWillReceiveProps: (nextProps) ->


#   componentWillUpdate: ->
#     # console.log("componentWillUpdate", @_UUID, @constructor.displayName)
#     # console.time("update #{@_UUID}")

#   componentDidUpdate: ->
#     # console.timeEnd("update #{@_UUID}")

#   componentWillUnmount: ->
#     @unsubscribefromStoreChanges()


#   ###

#   Helpers

#   ###


#   parseDataBindings: ->
#     @_dataBindings = parseDataBindings(@dataBindings)

#   getData: ->
#     data = {}
#     for stateKey, storeKey of @_dataBindings
#       data[stateKey] = @app.get(storeKey)
#     data


#   subscribeToStoreChanges: ->
#     console.time('')
#     for stateKey, storeKey of @_dataBindings
#       @app.sub "store:change:#{storeKey}", @storeChange

#   unsubscribefromStoreChanges: ->
#     for stateKey, storeKey of @_dataBindings
#       @app.unsub "store:change:#{storeKey}", @storeChange




#   storeChange: (event, key) ->
#     return unless @isMounted()
#     @app.stats.storeChangeRerenders++
#     for stateKey, storeKey of @_dataBindings
#       if key == storeKey
#         @setState "#{stateKey}": @app.get(storeKey)


#   rerender: ->
#     return unless @isMounted()
#     # console.count("rerender #{@constructor.displayName}")
#     # console.info("rerender #{@constructor.displayName}", event, payload)
#     @forceUpdate()

#   ### DATA BINDINGS MIXIN ###



#   # get: (key) ->
#   #   if @_dataBindings.excludes(key)
#   #     @_dataBindings.push(key)

#   #   @app.get(key)

#   # componentWillUnmount: ->
#   #   for key in @_dataBindings
#   #     @app.unsub "store:change:#{key}", @storeChange

#   # componentDidUpdate: ->
#   #   for key in @_dataBindings
#   #     @app.sub "store:change:#{key}", @storeChange


#   # storeChange: (event, key) ->
#   #   @app.stats.rerenders++
#   #   @rerender()


#   ### / DATA BINDINGS MIXIN ###


#   ### STYLES MIXIN ###

#   style: ->
#     new Style(@defaultStyle)
#       .update(@props.style)
#       .update(@styleFromProps())
#       .update(@enforcedStyle)

#   cloneProps: ->
#     props = Object.clone(@props)

#     # # TODO delete any props listed by PropTypes
#     # debugger if this.constructor.displayName == 'DirectoryContents'
#     # keys = Object.keys(this.propTypes||{})
#     # delete props[key] for key in keys

#     props.style = @style()
#     props

#   extendProps: (props) ->
#     Object.assign(@cloneProps(), props)

#   styleFromProps: ->
#     style = {}
#     for key, value of STYLE_PROPERTIES
#       style[value] = @props[key] if @props[key]?
#     style


#   ### / STYLES MIXIN ###
