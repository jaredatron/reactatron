React = require './React'
Style = require './Style'

module.exports = withSyle = (style, element) ->
  throw new Error('with style requires one ReactElement') unless element
  style = Style(element.props?.style? || {}).extend(style)
  React.cloneElement element, style: style


