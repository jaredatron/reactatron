Box = require './Box'

module.exports = Box.extendStyledComponent 'Columns',
  # height: '100%'
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'row'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
