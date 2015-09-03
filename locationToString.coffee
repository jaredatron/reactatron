objectToSearch = require './objectToSearch'

module.exports = ({path, params}) ->
  "#{path}#{objectToSearch(params)}"
