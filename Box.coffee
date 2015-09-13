{div} = require './DOM'

module.exports = div.withStyle 'Box',
  display: 'block'
  border: 'none'
  # overflow: 'hidden'
  margin: 0
  padding: 0
  flexShrink: 0
  flexGrow: 0
  WebkitBoxSizing: 'border-box'
  MozBoxSizing: 'border-box'
  boxSizing: 'border-box'



