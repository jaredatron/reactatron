Box = require './Box'

module.exports = Box.withStyle 'Rows',
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'column'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
  flexBasis: '100%'
  # maxWidth: '100%'
  # maxHeight: '100%'
