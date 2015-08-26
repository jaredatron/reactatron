Box = require './Box'

module.exports = Box.extendStyledComponent 'Rows',
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'column'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
