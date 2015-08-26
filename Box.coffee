styledComponent = require './styledComponent'
{div} = require './DOM'


module.exports = styledComponent 'Box', div,
  display: 'block'
  border: 'none'
  overflow: 'hidden'
  margin: 0
  padding: 0
  flexShrink: 0
  flexGrow: 0

