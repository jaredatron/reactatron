require 'stdlibjs/Object.clone'
React = require 'react'
component = require './component'
DOM = Object.create(React.DOM)

DOM.a = component 'a (reactatron)',

  contextTypes:
    setLocation: component.PropTypes.func

  onClick: (event) ->
    return unless event
    return unless target = event.target
    return unless target.nodeName == 'A'
    uri = parseURI(target.href)
    return unless uri.isSameOrigin
    event.preventDefault()
    console.log('a.onClick', target.href)
    @context.setLocation(uri.asRelative)
    return

  render: ->
    props = Object.clone(@props)
    props.onClick = @onClick
    React.createElement('a', props)

module.exports = DOM







# hopefully this is all the uri parsing we'll ever need to do.

URI = require 'uri-js'

parseURI = (href) ->
  uri = URI.parse(href)
  uri.origin = uri.scheme+'://'+uri.host
  uri.asRelative = href.replace(uri.origin,'')
  uri.isSameOrigin = uri.origin == location.origin
  uri



