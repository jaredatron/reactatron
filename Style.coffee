require 'stdlibjs/Object.assign'

module.exports = class Style

  @merge: ->
    style = new Style
    for otherStyle in arguments
      style.update(otherStyle)
    style

  constructor: (style) ->
    @update(style) if style?

  clone: ->
    new Style(this)

  update: (styles...) ->
    for style in styles
      assign(this, style) if style?
    this

  merge: (style) ->
    @clone().update(style)

  compute: (state={}) ->
    style = {}
    keys = Object.keys(this)
    for key in keys
      if key.match(/^:(.+)/)
        Object.assign(style, this[key]) if state[RegExp.$1]
      else
        style[key] = this[key]
    style




assign = (a, b) ->
  keys = Object.keys(b)
  for key in keys
    a[key] = if key.match(/^:/)
      Object.assign({}, a[key] || {}, b[key] || {})
    else
      b[key]
  a
