createClass   = require('react/lib/ReactClass').createClass
createElement = require('react/lib/ReactElement').createElement

module.exports = (spec) ->
  spec.displayName ||= 'AnonymousReactComponent'

  initialize = (props, context) ->
    # called with new when being mounted
    if this instanceof Constructor
      @props   = props
      @context = context
      @state   = @getInitialState?() || null
      return this

    # called without new when being generating the initial tree
    return createElement(Constructor, arguments...)



  Constructor = eval """
    #{spec.displayName} = function(){
      return initialize.apply(this, arguments);
    };
  """

  reactClass = createClass(spec)
  Object.assign(Constructor, reactClass)
  Constructor.prototype = reactClass.prototype
  Constructor.prototype.constructor = Constructor
  Constructor.type = Constructor
  Constructor


