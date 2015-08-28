require 'stdlibjs/Object.clone'
React = require 'react'
component = require './component'

module.exports = component 'Link',


  location: ->
    @app.locationFor(@props.path, @props.params)

  onClick: (event) ->
    if event?
      return if event.shiftKey || event.metaKey || event.ctrlKey
      event.preventDefault()

    if @props.onClick
      @props.onClick(event)
      return

    if @props.path? || @props.params?
      @app.setLocation @location()
      return

  defaultStyle:
    cursor: 'pointer'
    color: 'inherit'
    textDecoration: 'none'

  render: ->
    props = @cloneProps()
    props.onClick = @onClick
    props.href = @location() if props.path? || props.params?
    props.href ||= ''
    React.createElement('a', props)
