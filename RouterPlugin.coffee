Router = require './Router'
component = require './component'
Block = require './Block'

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

  start: ->
    @update()
    @app.sub 'store:change:location', @update
    this

  stop: ->
    @app.unsub 'store:change:location', @update
    this

  update: ->
    if location = @app.get('location')
      @app.set route: @router.routeFor(location)


RouteComponent = component 'RouteComponent',
  dataBindings: ->
    route: 'route'

  render: ->
    route = @state.route
    return Block {}, 'route undefined :(' if !route?
    page = @app.router.pageForRoute(route)
    page(route.params)
