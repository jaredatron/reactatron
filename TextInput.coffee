component = require './component'
Block = require './Block'
Columns = require './Columns'
{input, textarea} = require './DOM'

module.exports = component 'TextInput',

  getValue: ->
    @refs.input.getDOMNode().value

  defaultStyle:
    padding: '6px 12px'
    border: '1px solid #ccc'
    borderRadius: '4px'
    boxShadow: 'inset 0 1px 1px rgba(0,0,0,.075)'
    alignItems: 'center'

  inputStyle:
    padding: 0
    border: 'none'
    outline: 'none'
    backgroundColor: 'transparent'
    flexGrow: 1
    flexShrink: 1


  render: ->
    props = @extendProps
      ref: 'input'
      style: @inputStyle

    Columns style: @style(),
      @props.beforeInput
      input(props)
      @props.afterInput

