global.expect = require('expect.js')



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
