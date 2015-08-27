require 'stdlibjs/Array#findIndex'
###

new ResponsiveSizePlugin
  window: global.window
  widths: [100, 400, 650, 800, 789, 1240, 2480]
  heights: [100, 400, 650, 800, 789, 1240, 2480]

###

module.exports = class ResponsiveSizePlugin

  constructor: (options) ->
    Object.bindAll(this)
    @window = options.window
    @widths = options.widths || [480, 768, 992, 1200]


# 480px
# 767px
# 768px
# 992px
# 1199px
# 1200px

  init: ->
    @update()

  start: ->
    @window.addEventListener 'resize', @update
    this

  stop: ->
    @window.removeEventListener 'resize', @update
    this

  update: ->
    # height = @window.innerHeight,
    width = @window.innerWidth
    horizontalSize = @widths.findIndex (max) -> width < max
    horizontalSize = @widths.length if horizontalSize == -1
    if horizontalSize != @app.get('horizontalSize')
      @app.set horizontalSize: horizontalSize
    this
