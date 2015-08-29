React = require 'react'
component = require './component'

DOM = {}

for key, value of React.DOM
  DOM[key] = component(value)

module.exports = DOM
