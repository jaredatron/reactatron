hyphenateStyleName = require 'react/lib/hyphenateStyleName'

module.exports = class Stylesheet
  constructor: (document) ->
    @stylesheet = injectStylesheet(document)

  appendRule: (rule) ->
    @stylesheet.insertRule(rule, @stylesheet.rules.length)

# # rule = ''+
# # '@keyframes spinIt {\n'+
# # '    100% {\n'+
# # '        transform: rotate(A_DYNAMIC_VALUE);\n'+
# # '    }\n'+
# # '}\n';
# # stylesheet.insertRule(rule, stylesheet.rules.length);







# # we need to make an animation library entierly in JS :D

injectStylesheet = (document) ->
  style = document.createElement('style');
  style.type = 'text/css'
  style.innerHTML = 'body {}'
  document.getElementsByTagName('head')[0].appendChild(style);
  document.styleSheets[document.styleSheets.length-1];
