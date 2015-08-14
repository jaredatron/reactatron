// App.coffee
ReactatronApp = require('reactatron/App')
App = new ReactatronApp
App.start()
App.stop()
App.path
App.params
App.setPath(path)
App.setParams(params)
App.setLocation(path, params)
App.on 'location:change',  @onLocationChange
App.off 'location:change', @onLocationChange
App.routes ->
  @match


// AbortButton.coffee
Component = require('reactatron/Component')
DOM = require('reactatron/DOM')
Glyph = require('components/Glyph')

module.exports = new Component 'AbortButton',
  render: ->
    {Button, span} = DOM
    Button
      className:'AbortButton'
      span(null, 'Abort')
      Glyph(glyph:'abort')
