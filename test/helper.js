React = require('react/addons')

expect = require('expect.js')
Assertion = expect.Assertion
TestUtils = React.addons.TestUtils

isElement      = TestUtils.isElement
isDOMComponent = TestUtils.isDOMComponent
findAllInRenderedTree = TestUtils.findAllInRenderedTree
isCompositeComponent = TestUtils.isCompositeComponent
isCompositeComponentElement = TestUtils.isCompositeComponentElement


Assertion.prototype.render = function(html) {
  expect(this.obj).to.be.a('function');
  expect(html).to.be.a('string');
  expect( renderToString({}, this.obj) ).to.eql(html);
};

// window = this
// location = {
//   pathname: '/',
//   search: '',
// }
// document = {}
// document.body = {'BODY': true}


FakeWindow = function(){
  return {
    location: {
      pathname: '/',
      search: '',
    },
    addEventListener: new CallLogger,
    removeEventListener: new CallLogger,
  };
};


CallLogger = function(){
  var callLogger = function(){
    callLogger.calls.push([].slice.call(arguments));
    callLogger.callCount = callLogger.calls.length;
  };
  callLogger.reset = function(){
    callLogger.calls = [];
    callLogger.callCount = 0;
  };
  callLogger.reset();

  return callLogger;
};


Counter = function(){
  var counter = function(){
    counter.value++;
  }
  counter.value = 0;
  return counter;
};


renderToString = function(app, render) {
  return React.renderToStaticMarkup(
    ContextWrapper({app: app, render: render})
  );
};

// renderComponent = function(app, component, props, children){
//   args = [].alice.call(arguments, 2);
//   return React.renderToStaticMarkup(
//     ContextWrapper({app: app}, Component.call(null, args))
//   );
// };


ContextWrapper = React.createFactory(React.createClass({
  displayName: 'ContextWrapper',
  childContextTypes: {
    app: React.PropTypes.object,
  },
  getChildContext: function(){
    return {
      app: this.props.app
    };
  },
  render: function(){
    return this.props.render()
  }

}))
