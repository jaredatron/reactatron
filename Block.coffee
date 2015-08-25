component = require './component'
Box = require './Box'

module.exports = component 'Block',

  defaultStyle:
    display: 'inline-flex'
    flexWrap: 'wrap'
    alignItems: 'flex-start'
    alignContent: 'flex-start'

  render: ->
    Box(@cloneProps())
