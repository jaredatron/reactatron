isArray = require 'stdlibjs/isArray'
Style = require './Style'
Props = require './Props'

prepareProps = (props, children...) ->
  new Props(props).appendChildren(children)


module.exports = prepareProps
