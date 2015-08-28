require 'stdlibjs/Object.bindAll'
RedirectComponent = require './RedirectComponent'

#
# Usage:
#
# router = new Router ->
#   @match '/',      @redirectTo('/shows')
#   @match '/shows', DOM.ShowsPage
#

class Router
  constructor: (spec) ->
    Object.bindAll(this)
    @routes = []
    @map(spec)

  map: (spec) ->
    spec.call(this)

  match: (expression, page) ->
    route = new Route(expression, page)
    route.id = @routes.length
    @routes.push route

  get: (id) ->
    @routes[id]

  routeFor: (location) ->
    {path, params} = location
    for route in @routes
      if match = route.match(path, params)
        return match
    throw new Error('route not found for '+path+' '+JSON.stringify(params))

  pageForRoute: (route) ->
    @get(route.id).page

  redirectTo: (path, params={}) ->
    return ->
      RedirectComponent(path: path, params: params)



module.exports = Router



# private

class Route
  constructor: (expression, page) ->
    @expression = expression
    @page = page
    parseExpression.call(this, expression)

  match: (path, params) ->
    parts = path.match(@regexp)
    return false unless parts
    parts.shift()
    params = Object.assign({}, params)
    @paramNames.forEach (paramName) ->
      params[paramName] = parts.shift()

    id: @id
    path: path
    params: params


escapeRegExp  = /[\-{}\[\]+?.,\\\^$|#\s]/g
namedParams   = /\/?(:|\*)([^\/?]+)/g
parseExpression = (expression) ->
  paramNames = []
  expression = expression.replace(escapeRegExp, '\\$&')
  expression = expression.replace namedParams, (_, type, paramName) ->
    paramNames.push(paramName)
    switch type
      when ':' then '/([^/?]+)'
      when '*' then '/(.*?)'
  @paramNames = paramNames
  @regexp = new RegExp("^#{expression}$")
