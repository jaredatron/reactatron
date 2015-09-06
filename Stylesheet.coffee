hyphenateStyleName = require 'react/lib/hyphenateStyleName'
injectStylesheet = require './injectStylesheet'

module.exports = class Stylesheet
  constructor: (document, styles) ->
    @stylesheet = injectStylesheet(document, styles)

  appendRule: (rule) ->
    debugger
    # This doesnt work in Safari :/
    @stylesheet.insertRule(rule, @stylesheet.rules.length)
