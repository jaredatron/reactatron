React     = require '../react'
expect    = require 'expect.js'

inspect   = expect.stringify
Assertion = expect.Assertion
TestUtils = React.addons.TestUtils


isElement                           = TestUtils.isElement
isElementOfType                     = TestUtils.isElementOfType
isDOMComponent                      = TestUtils.isDOMComponent
isDOMComponentElement               = TestUtils.isDOMComponentElement
isCompositeComponent                = TestUtils.isCompositeComponent
isCompositeComponentWithType        = TestUtils.isCompositeComponentWithType
isCompositeComponentElement         = TestUtils.isCompositeComponentElement
isCompositeComponentElementWithType = TestUtils.isCompositeComponentElementWithType
findAllInRenderedTree               = TestUtils.findAllInRenderedTree


Assertion.prototype.aReactElement = function(){
  var component = this.obj;
  this.assert(
      isElement(component)
    , function(){ return 'expected ' + inspect(component) + ' to be a React element' }
    , function(){ return 'expected ' + inspect(component) + ' to not be a React element' });
}

Assertion.prototype.render = function(html) {
  expect(this.obj).to.be.a('function');
  expect(html).to.be.a('string');
  expect( renderToString({}, this.obj) ).to.eql(html);
};


Assertion.prototype.aComponent = function() {
  expect(this.obj).to.be.a('function');
  expect(
    'string' == typeof this.obj.type ||
    'object' == typeof this.obj.type
  ).to.be(true)
};

// window = this
// location = {
//   pathname: '/',
//   search: '',
// }
// document = {}
// document.body = {'BODY': true}

