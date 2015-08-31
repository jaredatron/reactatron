ReactClass = require 'react/lib/ReactClass'
createElement = require('react/lib/ReactElement').createElement

module.exports = (spec) ->
  spec.displayName ||= 'AnonymousReactComponent'

  initialize = (props, context) ->
    return new Constructor(props, context) unless this instanceof Constructor
    @props   = props
    @context = context
    @state   = @getInitialState?() || null
    return createElement(this)

  Constructor = eval """
    #{spec.displayName} = function(props, context){ return initialize.call(this, props, context); };
  """

  ReactClass = ReactClass.createClass(spec)
  Object.assign(Constructor, ReactClass)
  Constructor.prototype.constructor = Constructor
  Constructor.type = Constructor
  Constructor


