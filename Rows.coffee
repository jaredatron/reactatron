component = require './component'
Box = require './Box'

module.exports = component 'Rows',

  defaultStyle:
    display: 'inline-flex'
    alignItems: 'stretch'
    alignContent: 'stretch'
    flexDirection: 'column'
    flexWrap: 'nowrap'
    justifyContent: 'flex-start'

  render: ->
    Box(@cloneProps())
