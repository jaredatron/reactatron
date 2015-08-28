hyphenateStyleName = require 'react/lib/hyphenateStyleName'

module.exports = class Stylesheet
  constructor: (document) ->
    @stylesheet = injectStylesheet(document)

  appendRule: (rule) ->
    @stylesheet.insertRule(rule, @stylesheet.rules.length)

injectStylesheet = (document) ->
  style = document.createElement('style');
  style.type = 'text/css'
  style.innerHTML = 'body {}'
  document.getElementsByTagName('head')[0].appendChild(style);
  document.styleSheets[document.styleSheets.length-1];
