React     = require '../React'
expect    = require 'expect.js'

inspect   = expect.stringify
Assertion = expect.Assertion
TestUtils = React.addons.TestUtils




Assertion.prototype.aReactElement = ->
  component = @obj
  @assert isElement(component),
    -> 'expected ' + inspect(component) + ' to be a React element'
    -> 'expected ' + inspect(component) + ' to not be a React element'


Assertion.prototype.render = (html) ->
  component = @obj
  expect( component                     ).to.be.a('function')
  expect( html                          ).to.be.a('string')
  expect( renderToString({}, component) ).to.eql(html)


Assertion.prototype.aComponent = ->
  component = @obj
  expect(component).to.be.a('function')
  @assert 'string' == typeof component.type || 'object' == typeof component.type,
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
  React.renderToStaticMarkup withContext({app:app}, render)



module.exports =
  inspect:        inspect
  withContext:    withContext
  renderToString: renderToString

Object.assign(module.exports, TestUtils)
