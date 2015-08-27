styledComponent = require './styledComponent'
{button} = require './DOM'

module.exports = styledComponent 'Button', button,
  cursor: 'pointer'
  display: 'inline-block'
  border: '0'
  background: 'none'
  overflow: 'hidden'
  margin: 0
  padding: 0
  backgroundColor: 'inherit'
