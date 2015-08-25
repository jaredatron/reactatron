component = require './component'
{div} = require './DOM'

module.exports = component 'Box',

  propTypes:
    alignItems: component.PropTypes.string
    grow: component.PropTypes.string

  defaultStyle:
    display: 'block'
    border: 'none'
    margin: 0
    padding: 0
    overflow: 'hidden'

  render: ->
    props = @cloneProps()
    style = props.style

    if @props.grow
      style.flexGrow = @props.grow


    style.alignItems = switch @props.alignItems
      when 'start' then 'flex-start'
      when 'end'   then 'flex-end'
      else @props.alignItems

    div(props)
