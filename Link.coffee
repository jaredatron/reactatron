require 'stdlibjs/Object.clone'

component = require './component'
{a} = require './DOM'

module.exports = component 'Link',


  location: ->
    @app.locationFor(@props.path, @props.params)

  onClick: (event) ->
    if event?
      return if event.shiftKey || event.metaKey || event.ctrlKey

    @props.onClick(event) if @props.onClick

    return if event? && event.defaultPrevented
    event.preventDefault()

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
    a(props)
