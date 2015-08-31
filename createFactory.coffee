ReactElementValidator = require 'react/lib/ReactElementValidator'

module.exports = (componentClass) ->
  ReactElementValidator.createElement.bind(null, componentClass)
