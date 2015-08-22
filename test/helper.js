global.expect = require('expect.js')



CountingHandler = function(){
  var countingHandler = function(){
    countingHandler.calls.push([].slice.call(arguments));
    countingHandler.callCount = countingHandler.calls.length;
  };
  countingHandler.calls = [];
  countingHandler.callCount = 0;
  return countingHandler;
};


Counter = function(){
  var counter = function(){
    counter.value++;
  }
  counter.value = 0;
  return counter;
};
