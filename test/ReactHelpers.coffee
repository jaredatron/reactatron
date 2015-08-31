React     = require '../React'
ReactElement = require 'react/lib/ReactElement'
expect    = require 'expect.js'

inspect   = expect.stringify
Assertion = expect.Assertion
TestUtils = React.addons.TestUtils




Assertion.prototype.aValidReactElement = ->
  element = @obj
  @assert ReactElement.isValidElement(element),
    -> 'expected ' + inspect(element) + ' to be a valid React element'
    -> 'expected ' + inspect(element) + ' to not be a valid React element'

Assertion.prototype.aReactElement = ->
  element = @obj
  @assert isElement(element),
    -> 'expected ' + inspect(element) + ' to be a React element'
    -> 'expected ' + inspect(element) + ' to not be a React element'


Assertion.prototype.render = (html) ->
  element = @obj
  expect( element                     ).to.be.a('function')
  expect( html                        ).to.be.a('string')
  expect( renderToString({}, element) ).to.eql(html)


Assertion.prototype.aComponent = ->
  component = @obj
  expect(component).to.be.a('function')
  typeoOfType = typeof component.type
  @assert 'string' ==  typeoOfType || 'object' == typeoOfType || 'function' == typeoOfType,
    -> 'expected ' + inspect(component) + ' to be a Component'
    -> 'expected ' + inspect(component) + ' to not be a Component'



withContext = (context, render) ->
  childContextTypes = {}
  for key of context
    childContextTypes[key] = React.PropTypes.any

  ContextProvider = React.createClass
    displayName: 'ContextProvider',
    childContextTypes: childContextTypes
    getChildContext: -> context
    render: -> render()

  return React.createElement(ContextProvider)


renderToString = (app, render) ->
  debugger
  React.renderToStaticMarkup withContext({app:app}, render)



module.exports =
  inspect:        inspect
  withContext:    withContext
  renderToString: renderToString

Object.assign(module.exports, TestUtils)
