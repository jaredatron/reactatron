React = require 'react'
BaseMixin = require './BaseMixin'


component = (name, spec) ->
  if ('string' != typeof name)
    spec = name
    name = null
  spec ||= {}
  spec.displayName = name if name?
  spec.mixins ||= []
  spec.mixins = [BaseMixin].concat(spec.mixins)

  # possibly process alternate API here

  component = React.createClass(spec)
  componentFactory = React.createFactory(component)
  componentFactory.component = component
  componentFactory

component.PropTypes = React.PropTypes

module.exports = component
