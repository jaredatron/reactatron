module.exports = class WindowSizePlugin

  constructor: (options) ->
    Object.bindAll(this)
    @window = options.window

  init: ->
    @update()

  start: ->
    @window.addEventListener 'resize', @update
    this

  stop: ->
    @window.removeEventListener 'resize', @update
    this

  update: ->
    @app.set windowSize: {
      height: @window.innerHeight,
      width:  @window.innerWidth,
    }
    this
