component = require './component'
Box = require './Box'

DEFAULT_STYLE = {
  display: 'inline-flex'
  flexWrap: 'wrap'
  alignItems: 'flex-start'
  alignContent: 'flex-start'
}

module.exports = component (props, children...) ->
  props.style = Object.assign({}, DEFAULT_STYLE, props.style || {})
  Box(props, children...)
