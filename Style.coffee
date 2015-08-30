require 'stdlibjs/Object.assign'
require 'stdlibjs/Array#unique'
isObject = require 'stdlibjs/isObject'



module.exports = class Style

  ###*
  # Document me!
  #
  ###
  @merge: ->
    style = new Style()
    style.update.apply(style, arguments)

  ###*
  # Document me!
  #
  ###
  constructor: ->
    style = this
    style = new Style unless style instanceof Style
    style.update.apply(style, arguments)
    return style

  ###*
  # Document me!
  #
  ###
  clone: ->
    new Style().update(this)

  ###*
  # Document me!
  #
  ###
  replace: (style) ->
    keys = Object.keys(this).concat(Object.keys(style)).unique()
    for key in keys
      if key of style
        this[key] = style[key]
      else
        delete this[key]
    this

  ###*
  # Document me!
  #
  ###
  update: (styles...) ->
    assign(this, style) for style in styles
    this

  ###
    @alias update
  ###
  extend: @::update

  ###*
  # Document me!
  #
  ###
  reverseUpdate: ->
    @replace @reverseMerge.apply(this, arguments)

  ###*
  # Document me!
  #
  ###
  merge: ->
    @update.apply(@clone(), arguments)

  ###*
  # Document me!
  #
  ###
  reverseMerge: ->
    Style.apply(null, arguments).update(this)

  META_SELECTOR_KEY = /^:(.+)/

  ###*
  # Document me!
  #
  ###
  compute: (state) ->
    style = {}
    keys = Object.keys(this)
    for key in keys
      if key.match(META_SELECTOR_KEY)
        Object.assign(style, this[key]) if state[RegExp.$1]
      else
        style[key] = this[key]
    style


assign = (left, right, deep=true) ->
  return left if !right?
  rightKeys = Object.keys(right)
  for key in rightKeys
    rightValue = right[key]
    if deep && isObject(rightValue)
      leftValue = left[key] ||= {}
      assign(leftValue, rightValue, false)
    else
      left[key] = rightValue
  left

