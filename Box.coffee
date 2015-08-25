component = require './component'
{div} = require './DOM'

module.exports = component 'Box',

  propTypes:
    alignItems: component.PropTypes.any
    grow: component.PropTypes.any

  defaultStyle:
    display: 'block'
    border: 'none'
    margin: 0
    padding: 0
    overflow: 'hidden'
    # flexShrink: 0

  render: ->
    props = @cloneProps()
    style = props.style

    style.flexGrow   = @props.grow      if @props.grow?
    style.flexShrink = @props.shrink    if @props.shrink?
    style.minWidth   = @props.minWidth  if @props.minWidth?
    style.overflowY  = @props.overflowY if @props.overflowY?
    style.overflowX  = @props.overflowX if @props.overflowX?
    style.overflow   = @props.overflow  if @props.overflow?

    div(props)
