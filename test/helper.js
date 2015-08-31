require('stdlibjs/Object.assign')

global.expect  = require('expect.js')
global.inspect = expect.stringify

global.FakeWindow = function(){
  return {
    location: {
      pathname: '/',
      search: '',
    },
    addEventListener: new CallLogger,
    removeEventListener: new CallLogger,
  };
};


global.CallLogger = function(){
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


global.Counter = function(){
  var counter = function(){
    counter.value++;
  }
  counter.value = 0;
  return counter;
};


Object.assign(global, require('./ReactHelpers'))
