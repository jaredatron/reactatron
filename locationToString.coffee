objectToSearch = require './objectToSearch'

module.exports = (location) ->
  try
    {path, params} = location
    "#{path}#{objectToSearch(params)}"
  catch
    "[BAD URL]"
