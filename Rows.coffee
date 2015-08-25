component = require './component'
Box = require './Box'

module.exports = component 'Rows',

  defaultStyle:
    display: 'inline-flex'
    flexDirection: 'column'
    flexWrap: 'nowrap'
    justifyContent: 'flex-start'

  render: ->
    Box(@cloneProps())
