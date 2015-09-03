module.exports = (app) ->

  window = app.window

  update = ->
    app.set windowSize:
      height: window.innerHeight
      width:  window.innerWidth

  app.sub 'start', ->
    update()
    window.addEventListener 'resize', update

  app.sub 'stop', ->
    window.removeEventListener 'resize', update

