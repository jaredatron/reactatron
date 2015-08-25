component = require './component'
Box = require './Box'

module.exports = component 'Block',

  defaultStyle:
    display: 'inline-block'

  render: ->
    Box(@cloneProps())
