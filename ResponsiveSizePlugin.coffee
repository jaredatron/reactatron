require 'stdlibjs/Array#findIndex'
###

new ResponsiveSizePlugin
  window: global.window
  widths: [100, 400, 650, 800, 789, 1240, 2480]
  heights: [100, 400, 650, 800, 789, 1240, 2480]

###

module.exports = (app) ->

  window = app.config.window

  widths = app.config.responsiveWidths || [480, 768, 992, 1200]

  update = ->
    # height = window.innerHeight,
    width = window.innerWidth
    horizontalSize = widths.findIndex (max) -> width < max
    horizontalSize = widths.length if horizontalSize == -1
    if horizontalSize != app.get('horizontalSize')
      app.set horizontalSize: horizontalSize


  app.sub 'start', ->
    update()
    window.addEventListener 'resize', update

  app.sub 'stop', ->
    window.removeEventListener 'resize', update


