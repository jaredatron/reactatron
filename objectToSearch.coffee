objectToQueryString = require './objectToQueryString'

module.exports = (params) ->
  search = objectToQueryString(params)
  if search.length == 0 then '' else '?'+search
