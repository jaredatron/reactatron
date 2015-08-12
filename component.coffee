React = require 'react'
BaseMixin = require './BaseMixin'
DOM = require './DOM'


component = (name, spec) ->
  if ('string' != typeof name)
    spec = name
    name = null
  spec ||= {}
  spec.displayName = name if name?
  spec.mixins ||= []
  spec.mixins = [BaseMixin].concat(spec.mixins)
  component = React.createClass(spec)
  componentFactory = React.createFactory(component)
  componentFactory.component = component
  if name?
    componentFactory.displayName = name
    DOM[name] = componentFactory
  componentFactory

component.DOM = DOM
component.PropTypes = React.PropTypes

module.exports = component
