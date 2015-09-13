Box = require './Box'

module.exports = Box.withStyle 'Columns',
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'row'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
  flexBasis: '100%'
  # height: '100%'
  # maxWidth: '100%'
  # maxHeight: '100%'
