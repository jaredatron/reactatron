require 'shouldhave/Object.bindAll'

createClass   = require('react/lib/ReactClass').createClass
createElement = require('react/lib/ReactElement').createElement

module.exports = (spec) ->
  spec.displayName ||= 'AnonymousReactComponent'

  initialize = (props, context) ->
    # called with new when being mounted
    if this instanceof Constructor
      bindAll(this)
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
  Constructor.type              = Constructor
  Constructor.displayName       = reactClass.displayName
  Constructor.propTypes         = reactClass.propTypes
  Constructor.contextTypes      = reactClass.contextTypes
  Constructor.childContextTypes = reactClass.childContextTypes
  Constructor.getDefaultProps   = reactClass.getDefaultProps
  Constructor.defaultProps      = reactClass.defaultProps
  Constructor.prototype         = reactClass.prototype
  Constructor.prototype.constructor = Constructor
  Constructor




bindAll = (instance) ->
  for key, value of instance
    continue if 'constructor' == key
    continue unless 'function' == typeof value
    instance[key] = value.bind(instance)
    instance[key].isReactClassApproved = true
