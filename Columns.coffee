styledComponent = require './styledComponent'
Box = require './Box'

module.exports = styledComponent 'Rows', Box,
  # height: '100%'
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'row'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
