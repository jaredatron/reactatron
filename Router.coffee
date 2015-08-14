React = require 'react'
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
    @routes = []
    @map(spec) if spec

  map: (spec) ->
    spec.call(this)

  match: (expression, page) ->
    @routes.push new Route(expression, page)

  pageFor: (path, params) ->
    for route in @routes
      if match = route.match(path, params)
        return match
    throw new Error('route not found for', path, params)

  redirectTo: (path, params={}) ->
    return ->
      return ->
        RedirectComponent(path: path, params: params)



module.exports = Router



# private

class Route
  constructor: (expression, page) ->
    @expression = expression
    @page  = page
    parseExpression.call(this, expression)

  match: (path, params) ->
    parts = path.match(@regexp)
    return false unless parts
    parts.shift()
    params = Object.assign({}, params)
    @paramNames.forEach (paramName) ->
      params[paramName] = parts.shift()
    route = Object.create(this)
    route.path = path
    route.params = params
    return route


escapeRegExp  = /[\-{}\[\]+?.,\\\^$|#\s]/g
namedParams   = /\/(:|\*)([^\/?]+)/g
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
