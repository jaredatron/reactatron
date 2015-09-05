require 'shouldhave/Object.assign'
createFactory = require './createFactory'
React = require './React'
ReactTransitionChildMapping = require 'react/lib/ReactTransitionChildMapping'
cloneWithProps = require 'react/lib/cloneWithProps'
emptyFunction = require 'react/lib/emptyFunction'

module.exports = createFactory React.createClass
  displayName: 'ReactatronTransitionGroup',

  propTypes:
    component: React.PropTypes.any,
    childFactory: React.PropTypes.func

  getDefaultProps: ->
    component: React.DOM.span
    childFactory: emptyFunction.thatReturnsArgument

  getInitialState: ->
    children: ReactTransitionChildMapping.getChildMapping(this.props.children)

  componentWillMount: ->
    @currentlyTransitioningKeys = {}
    @keysToEnter = []
    @keysToLeave = []


  componentDidMount: ->
    initialChildMapping = @state.children
    for key of initialChildMapping
      if initialChildMapping[key]
        @performAppear(key)


  componentWillReceiveProps: (nextProps) ->
    nextChildMapping = ReactTransitionChildMapping.getChildMapping(nextProps.children)
    prevChildMapping = @state.children;

    @setState
      children: ReactTransitionChildMapping.mergeChildMappings(prevChildMapping, nextChildMapping)

    for key of nextChildMapping
      hasPrev = prevChildMapping && prevChildMapping.hasOwnProperty(key)
      if nextChildMapping[key] && !hasPrev && !@currentlyTransitioningKeys[key]
        @keysToEnter.push key

    for key of prevChildMapping
      hasNext = nextChildMapping && nextChildMapping.hasOwnProperty(key);
      if prevChildMapping[key] && !hasNext && !this.currentlyTransitioningKeys[key]
        @keysToLeave.push key


  componentDidUpdate: ->
    keysToEnter = @keysToEnter
    @keysToEnter = []
    keysToEnter.forEach(@performEnter)

    keysToLeave = @keysToLeave
    @keysToLeave = []
    keysToLeave.forEach(@performLeave)


  performAppear: (key) ->
    @currentlyTransitioningKeys[key] = true

    component = @refs[key];

    if component.componentWillAppear?
      component.componentWillAppear @_handleDoneAppearing.bind(this, key)
    else
      @_handleDoneAppearing(key)


  _handleDoneAppearing: (key) ->
    component = this.refs[key]
    component.componentDidAppear?()

    delete @currentlyTransitioningKeys[key];

    currentChildMapping = ReactTransitionChildMapping.getChildMapping(@props.children)

    if !currentChildMapping || !currentChildMapping.hasOwnProperty(key)
      # This was removed before it had fully appeared. Remove it.
      this.performLeave(key)

  performEnter: (key) ->
    @currentlyTransitioningKeys[key] = true

    component = this.refs[key]

    if component.componentWillEnter?
      component.componentWillEnter @_handleDoneEntering.bind(this, key)
    else
      @_handleDoneEntering(key)


  _handleDoneEntering: (key) ->
    component = this.refs[key]
    component.componentDidEnter?()

    delete @currentlyTransitioningKeys[key]

    currentChildMapping = ReactTransitionChildMapping.getChildMapping(@props.children)

    if !currentChildMapping || !currentChildMapping.hasOwnProperty(key)
      # This was removed before it had fully entered. Remove it.
      this.performLeave(key);

  performLeave: (key) ->
    @currentlyTransitioningKeys[key] = true;

    component = @refs[key];

    if component.componentWillLeave?
      component.componentWillLeave @_handleDoneLeaving.bind(this, key)
    else
      # Note that this is somewhat dangerous b/c it calls setState()
      # again, effectively mutating the component before all the work
      # is done.
      @_handleDoneLeaving(key)


  _handleDoneLeaving: (key) ->
    component = @refs[key]

    component.componentDidLeave?()

    delete @currentlyTransitioningKeys[key];

    currentChildMapping = ReactTransitionChildMapping.getChildMapping(@props.children)

    if currentChildMapping && currentChildMapping.hasOwnProperty(key)
      # This entered again before it fully left. Add it again.
      @performEnter(key);
    else
      newChildren = Object.assign({}, @state.children);
      delete newChildren[key]
      @setState children: newChildren


  render: ->
    # TODO: we could get rid of the need for the wrapper node
    # by cloning a single child
    childrenToRender = [];
    for key, child of @state.children
      if (child)
        # You may need to apply reactive updates to a child as it is leaving.
        # The normal React way to do it won't work since the child will have
        # already been removed. In case you need this behavior you can provide
        # a childFactory function to wrap every child, even the ones that are
        # leaving.
        clone = cloneWithProps(@props.childFactory(child), {ref: key, key: key})
        childrenToRender.push clone

    @props.component(@props, childrenToRender)

