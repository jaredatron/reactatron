AppMixin = require './AppMixin'


# global.RENDER_STATS = {}
# RENDER_STATS.reset = ->
#   RENDER_STATS.componentsInitialized =  []
#   RENDER_STATS.componentsMounted =  []
#   RENDER_STATS.componentsUpdated =  []
#   RENDER_STATS.componentsUnmounted =  []
# RENDER_STATS.reset()



module.exports =
  mixins: [AppMixin]

  getInitialState: ->
    # @app?.stats?.componentsInitialized++
    # RENDER_STATS.componentsInitialized.push([@constructor.displayName])
    {}

  componentDidMount: ->
    @app?.stats?.componentsMounted++
    # RENDER_STATS.componentsMounted.push(report(this))

  componentDidUpdate: (prevProps, prevState) ->
    @app?.stats?.componentsUpdated++
    # RENDER_STATS.componentsUpdated.push(report(this))
    # console.info('componentDidUpdate', @constructor.displayName, {@props, @state, prevProps, prevState})

  componentWillUnmount: ->
    @app?.stats?.componentsUnmounted++
    # RENDER_STATS.componentsUnmounted.push(report(this))



# report = (component) ->
#   node = component.getDOMNode()
#   "#{component.constructor.displayName} #{node.nodeName} #{node.innerText}"

