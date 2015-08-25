require 'stdlibjs/Object.clone'
React = require 'react'
component = require './component'

module.exports = component 'Link',

  onClick: (event) ->
    return unless event
    return unless target = event.target
    return unless target.nodeName == 'A'
    uri = parseURI(target.href)
    return unless uri.isSameOrigin
    event.preventDefault()
    @app.setLocation(uri.asRelative)
    return

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



