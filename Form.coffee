component = require './component'
{form} = require './DOM'

module.exports = component (props) ->
  # props.children
  form(props)
