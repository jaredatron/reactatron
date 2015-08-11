React = require 'react'

module.exports = (name, spec) ->
  if ('string' != typeof name)
    spec = name
    name = null
  spec ||= {}
  spec.displayName = name if name?
  component = React.createClass(spec)
  componentFactory = React.createFactory(component)
  componentFactory.component = component
  componentFactory.displayName = name
  componentFactory
