# Router = require './Router'
component = require './component'
Block = require './Block'
parseRouteExpression = require './parseRouteExpression'
isString = require 'shouldhave/isString'


LocationPlugin = require './LocationPlugin'

module.exports = (app) ->

  LocationPlugin(app)

  app.router = new Router(app.config.routes)

  update = ->
    app.route = app.router.route(app.path, app.params)
    app.pub 'route:change', app.route

  update()
  app.sub 'location:change', update


class Router
  constructor: (routes) ->
    @routes = for pattern, value of routes
      new Route(pattern, value)

  route: (path, params) ->
    for route in @routes
      match = route.match(path, params)
      return match if match

class Route
  constructor: (@pattern, @value) ->
    @isARedirect = isString(@value)
    {@paramNames, @regexp} = parseRouteExpression(@pattern)


  match: (path, params) ->
    parts = path.match(@regexp)
    return false unless parts
    parts.shift()
    params = Object.assign({}, params)
    @paramNames.forEach (paramName) ->
      params[paramName] = parts.shift()

    if @isARedirect
      {
        isARedirect: true
        path: path
        params: params
        location:
          path: @value # complex pattens not supported yet
          params: params
          replace: true
      }
    else
      {
        path: path
        params: params
        component: @value
      }
