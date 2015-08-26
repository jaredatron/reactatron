styledComponent = require './styledComponent'
Box = require './Box'

module.exports = styledComponent 'Layer', Box,
  display: 'flex'
  alignItems: 'stretch'
  alignContent: 'stretch'

  position: 'fixed'
  top:      0
  left:     0
  bottom:   0
  right:    0
  height:   '100%'
  width:    '100%'
  overflow: 'hidden'

