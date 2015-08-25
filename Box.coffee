component = require './component'
{div} = require './DOM'

module.exports = component 'Box',

  defaultStyle:
    display: 'block'
    border: 'none'
    margin: 0
    padding: 0
    overflow: 'hidden'

  render: ->
    div(@cloneProps())
