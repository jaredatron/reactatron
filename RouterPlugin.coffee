Router = require './Router'
component = require './component'
Block = require './Block'

###

new ResponsiveSizePlugin
  window: global.window
  widths: [100, 400, 650, 800, 789, 1240, 2480]
  heights: [100, 400, 650, 800, 789, 1240, 2480]

###

module.exports = (app, spec) ->

  app.router = new Router(spec)

  app.MainComponent = RouteComponent

  update = ->
    if location = app.get('location')
      route = app.router.routeFor(location)
      currentRoute = app.get('route')
      if !currentRoute || route.id != currentRoute.id
        app.set route: route

  app.sub 'start', ->
    app.sub 'store:change:location', update

  app.sub 'stop', ->
    app.unsub 'store:change:location', update


RouteComponent = component 'RouteComponent',
  dataBindings: ->
    route: 'route'

  render: ->
    route = @state.route
    return Block {}, 'route undefined :(' if !route?
    page = @app.router.pageForRoute(route)
    page(route.params)
