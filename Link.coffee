require 'stdlibjs/Object.clone'
React = require 'react'
component = require './component'

module.exports = component 'Link',

  onClick: (event) ->
    target = @getDOMNode()
    uri = parseURI(target.href)
    if uri.isSameOrigin
      event.preventDefault() if event?
      @app.setLocation(uri.asRelative)

  defaultStyle:
    color: 'inherit'
    textDecoration: 'none'

  render: ->
    props = @cloneProps()
    if !props.href?
      props.href = @app.locationFor(@props.path, @props.params)
      props.onClick = @onClick

    React.createElement('a', props)

# hopefully this is all the uri parsing we'll ever need to do.

URI = require 'uri-js'

parseURI = (href) ->
  uri = URI.parse(href)
  uri.origin = uri.scheme+'://'+uri.host
  uri.asRelative = href.replace(uri.origin,'')
  uri.isSameOrigin = uri.origin == location.origin
  uri



