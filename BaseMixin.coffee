require 'stdlibjs/Object.type'
require 'stdlibjs/Array#excludes'

React = require 'react'

Style    = require './Style'
AppMixin = require './AppMixin'

STYLE_PROPERTIES =
  grow:     'flexGrow'
  shrink:   'flexShrink'
  width:    'width'
  minWidth: 'minWidth'
  maxWidth: 'maxWidth'

module.exports =

  # TODO remove this. Not all components need the AppMixin
  mixins: [AppMixin]

  style: ->
    new Style(@defaultStyle)
      .update(@props.style)
      .update(@styleFromProps())
      .update(@enforcedStyle)

  cloneProps: ->
    props = Object.clone(@props)

    # # TODO delete any props listed by PropTypes
    # debugger if this.constructor.displayName == 'DirectoryContents'
    # keys = Object.keys(this.propTypes||{})
    # delete props[key] for key in keys

    props.style = @style()
    props

  extendProps: (props) ->
    Object.assign(@cloneProps(), props)

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
