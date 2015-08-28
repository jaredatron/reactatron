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
    @app.router = @router
    @app.RouteComponent = RouteComponent
    @update()

  start: ->
    @app.sub 'store:change:location', @update
    this

  stop: ->
    @app.unsub 'store:change:location', @update
    this

  update: ->
    @app.set route: @router.routeFor(@app.get('location'))


RouteComponent = component 'RouteComponent',
  render: ->
    route = @get('route')
    page = @app.router.pageForRoute(route)
    page(route.params)
