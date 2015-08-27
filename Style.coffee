require 'stdlibjs/Object.assign'

module.exports = class Style

  constructor: (style) ->
    @update(style)

  clone: ->
    new Style(this)

  update: (style) ->
    assign(this, style || {})
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
