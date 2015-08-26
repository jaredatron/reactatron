styledComponent = require './styledComponent'
Box = require './Box'

module.exports = styledComponent 'Rows', Box,
  display: 'inline-flex'
  alignItems: 'stretch'
  alignContent: 'stretch'
  flexDirection: 'column'
  flexWrap: 'nowrap'
  justifyContent: 'flex-start'
