ReactElementValidator = require 'react/lib/ReactElementValidator'

prepareProps = require './prepareProps'

module.exports = (ReactComponentClass) ->
  factory = ->
    props = prepareProps.apply(null, arguments)
    ReactElementValidator.createElement(ReactComponentClass,props)
  factory.type = ReactComponentClass
  factory


