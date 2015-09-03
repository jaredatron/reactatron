parseRouteExpression = require './parseRouteExpression'

module.exports = class SimpleRouter
  constructor: (spec) ->
    @spec = spec

  route: (location) ->
    context =
      path:   location.path
      params: location.params
      match:  match
    @spec.apply(context)

match = (expression) ->
  {paramNames, regexp} = parseRouteExpression(expression)
  parts = @path.match(regexp)
  return false unless parts
  parts.shift()
  @params = {}
  paramNames.forEach (paramName) =>
    @params[paramName] = decode(parts.shift())
  return true


decode = (part) ->
  decodeURIComponent(part.replace('+',' '))
