Router = require './Router'
component = require './component'

###

new ResponsiveSizePlugin
  window: global.window
  widths: [100, 400, 650, 800, 789, 1240, 2480]
  heights: [100, 400, 650, 800, 789, 1240, 2480]

###

module.exports = class RouterPlugin

  constructor: (spec) ->
    Object.bindAll(this)
    @router = new Router(spec)

  init: ->
    @update()
    @app.router = @router
    @app.RouteComponent = RouteComponent

  start: ->
    @app.sub 'store:change:location', @update
    this

  stop: ->
    @app.unsub 'store:change:location', @update
    this

  update: ->
    route = @router.routeFor(@app.get('location'))
    @app.set
      routeIndex: route.index
      path:       route.params
      params:     route.params
    this


RouteComponent = component 'RouteComponent',
  render: ->
    @app.router.get(@get('routeIndex')).page()
