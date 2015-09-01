React = require './React'
Style = require './Style'

module.exports = withSyle = (style, element) ->
  React.cloneElement element,
    style: Style(element.props.style).extend(style)


