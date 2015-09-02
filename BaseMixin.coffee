require 'stdlibjs/Object.type'
require 'stdlibjs/Array#excludes'

React = require './React'

Style    = require './Style'
Props    = require './Props'
AppMixin = require './AppMixin'
StatsMixin = require './StatsMixin'

STYLE_PROPERTIES =
  grow:     'flexGrow'
  shrink:   'flexShrink'
  width:    'width'
  minWidth: 'minWidth'
  maxWidth: 'maxWidth'

module.exports =

  # TODO remove this. Not all components need the AppMixin
  mixins: [AppMixin, StatsMixin]

  style: ->
    Style(@defaultStyle)
      .extend(@props.style)
      .extend(@styleFromProps())
      .extend(@enforcedStyle)

  cloneProps: ->
    props = Props(@props)

    # # TODO delete any props listed by PropTypes
    # debugger if this.constructor.displayName == 'DirectoryContents'
    # keys = Object.keys(this.propTypes||{})
    # delete props[key] for key in keys

    props.style = @style()
    props

  extendProps: (props) ->
    @cloneProps().extend(props)

  # TODO remove this
  styleFromProps: ->
    style = {}
    for key, value of STYLE_PROPERTIES
      style[value] = @props[key] if @props[key]?
    # if Object.keys(style).length > 0
    #   console.warn('dont use style props')
    #   console.trace()
    style

  rerender: ->
    return unless @isMounted()
    # console.count("rerender #{@constructor.displayName}")
    # console.info("rerender #{@constructor.displayName}", event, payload)
    @forceUpdate()




