Stylesheet = require './Stylesheet'
Keyframes = require './Keyframes'

setValueForStyles = require('react/lib/CSSPropertyOperations').setValueForStyles
ReactTransitionEvents = require('react/lib/ReactTransitionEvents')


module.exports = class Animator
  constructor: (document) ->
    @stylesheet = new Stylesheet(document)

  registerKeyframes: (name, spec) ->
    keyframes = new Keyframes(name, spec)
    @stylesheet.appendRule keyframes.toRule()

  animate: (spec) ->
    new Animation(spec).start()


class Animation

  constructor: (options) ->
    Object.bindAll(this)
    @target   = options.target
    @name     = options.name
    @duration = options.duration || '1s'
    @fillmode = options.fillmode || 'both'
    @done     = options.done

  reset: ->
    setValueForStyles @target,
      animationName:     ''
      animationDuration: ''
      animationFillMode: ''

  start: ->
    @reset()
    ReactTransitionEvents.addEndEventListener(@target, @onEndEvent)
    setTimeout =>
      setValueForStyles @target,
        animationName:     @name
        animationDuration: @duration
        animationFillMode: @fillMode

  stop: ->
    ReactTransitionEvents.removeEndEventListener(@target, @onEndEvent)
    @done?()
    this

  onEndEvent: (event) ->
    @stop()
