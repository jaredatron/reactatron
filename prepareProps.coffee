isArray = require 'stdlibjs/isArray'
Style = require './Style'
Props = require './Props'

prepareProps = (props, children...) ->
  Props(props).appendChildren(children)


module.exports = prepareProps
