styledComponent = require './styledComponent'
{div} = require './DOM'


module.exports = styledComponent 'Box', div,
  display: 'block'
  border: 'none'
  margin: 0
  padding: 0
  overflow: 'hidden'


  # style = props.style = Object.assign({}, DEFAULT_STYLE, props.style || {})
  # # TODO stop doing this :S
  # # We need to stop doing this or move it to the front, at the end will cause over-writes
  # style.flexGrow   = props.grow      if props.grow?
  # style.flexShrink = props.shrink    if props.shrink?
  # style.minWidth   = props.minWidth  if props.minWidth?
  # style.overflowY  = props.overflowY if props.overflowY?
  # style.overflowX  = props.overflowX if props.overflowX?
  # style.overflow   = props.overflow  if props.overflow?
  # # Object.assign(style, Object.slice(props, PROPS_TO_STYLE))
  # div(props, children...)
