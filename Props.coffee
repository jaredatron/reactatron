require 'stdlibjs/Object.assign'
require 'stdlibjs/Array#unique'
isArray = require 'stdlibjs/isArray'
toArray = require 'stdlibjs/toArray'
Style = require './Style'


module.exports = class Props

  ###*
  # Document me!
  #
  ###
  constructor: (props={}) ->
    return props if props instanceof Props
    return new Props(props) unless this instanceof Props
    return @extend(props)


  extend: (props) ->
    for key, value of props
      switch key
        when 'style'
          this.style = mergeStyles(this.style, value)
        when 'children'
          this.children = mergeChildren(this.children, value)
        else
          this[key] = value
    this

  reverseExtend: (prop) ->
    for key, value of props
      switch key
        when 'style'
          mergeStyle(this, value)
        when 'children'
          mergeChildren(this, value)
        else
          this[key] = value
    this

  appendChildren: (children) ->
    this.children = mergeChildren(this.children, children)
    this

  extendStyle: (style) ->
    if this.style
      this.style = Style(this.style).extend(style)
    else
      this.style = Style(style)
    this


isEmptyArray = (object) ->
  isArray(object) && object.length == 0

mergeStyles = (left, right) ->
  return left if !right?
  return right if !left?
  Style(left).merge(right)

mergeChildren = (left, right) ->
  return left  if !right? || isEmptyArray(right)
  return right if !left?  || isEmptyArray(right)
  toArray(left).concat(toArray(right))
