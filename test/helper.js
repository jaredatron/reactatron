React = require('react/addons')

expect = require('expect.js')
TestUtils = React.addons.TestUtils

isElement      = TestUtils.isElement
isDOMComponent = TestUtils.isDOMComponent
findAllInRenderedTree = TestUtils.findAllInRenderedTree

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


renderComponent = function(component){
  return React.renderToStaticMarkup(component);
};
