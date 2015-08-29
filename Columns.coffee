Box = require './Box'

module.exports = Box.withStyle 'Columns',
  # height: '100%'
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'row'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
  maxWidth: '100%'
  maxHeight: '100%'
