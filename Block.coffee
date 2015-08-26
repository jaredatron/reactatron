Box = require './Box'

module.exports = Box.extendStyledComponent 'Block',
  display: 'inline-flex'
  flexWrap: 'wrap'
  alignItems: 'flex-start'
  alignContent: 'flex-start'
  flexGrow: 0
  flexShrink: 0
