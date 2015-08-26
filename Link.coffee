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

  render: ->
    props = Object.clone(@props)
    props.onClick = @onClick
    props.href = @app.locationFor(@props.path, @props.params)
    React.createElement('a', props)

# hopefully this is all the uri parsing we'll ever need to do.

URI = require 'uri-js'

parseURI = (href) ->
  uri = URI.parse(href)
  uri.origin = uri.scheme+'://'+uri.host
  uri.asRelative = href.replace(uri.origin,'')
  uri.isSameOrigin = uri.origin == location.origin
  uri



