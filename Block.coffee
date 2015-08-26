styledComponent = require './styledComponent'
Box = require './Box'

module.exports = styledComponent 'Block', Box,
  display: 'inline-flex'
  flexWrap: 'wrap'
  alignItems: 'flex-start'
  alignContent: 'flex-start'
  flexGrow: 0
  flexShrink: 0
