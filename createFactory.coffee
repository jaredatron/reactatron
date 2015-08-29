ReactElementValidator = require 'react/lib/ReactElementValidator'

module.exports = (ReactComponentClass) ->
  factory = (args...) ->
    ReactElementValidator.createElement(ReactComponentClass,args...)
  factory.type = ReactComponentClass
  factory
