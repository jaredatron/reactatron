component = require './component'
{span} = require './DOM'

module.exports = component 'Text',

  defaultStyle:
    display: 'inline'

  render: ->
    span(@cloneProps())
