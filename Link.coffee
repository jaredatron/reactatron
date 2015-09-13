require 'shouldhave/Object.clone'

component = require './component'
{a} = require './DOM'

module.exports = component 'Link',

  location: ->
    @app.locationFor()

  onClick: (event) ->
    if event?
      return if event.shiftKey || event.metaKey || event.ctrlKey

    @props.onClick(event) if @props.onClick

    return if event? && event.defaultPrevented

    if @props.path? || @props.params?
      event.preventDefault()
      @app.setLocation(@props)
      return

    event.preventDefault() unless @props.href?

  defaultStyle:
    cursor: 'pointer'
    color: 'inherit'
    textDecoration: 'none'

  render: ->
    props = @cloneProps()
    props.onClick = @onClick
    if @props.path? || @props.params?
      props.href = @app.locationToString(@props)
    props.href ||= ''
    a(props)
