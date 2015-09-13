objectToSearch = require './objectToSearch'

module.exports = (path, params) ->
  path = "/#{path}" unless path[0] == '/'
  "#{path}#{objectToSearch(params)}"
