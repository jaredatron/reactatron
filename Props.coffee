require 'stdlibjs/Object.assign'
require 'stdlibjs/Array#unique'
isArray = require 'stdlibjs/isArray'
Style = require './Style'


module.exports = class Props

  ###*
  # Document me!
  #
  ###
  constructor: (props={}) ->
    return new Props(props) unless this instanceof Props
    return @extend(props)


  extend: (props) ->
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
    mergeChildren(this, children)

  extendStyle: (style) ->
    if this.style
      this.style.extend(style)
    else
      this.style = style
    this


mergeStyle = (props, style) ->
  return unless style?
  if props.style
    if props.style instanceof Style
      props.style.extend(style)
    else
      props.style = new Style(props.style).extend(style)
  else
    props.style = style

mergeChildren = (props, children) ->
  return unless children?
  childrenIsArray = isArray(children)
  return if childrenIsArray && children.length == 0

  if props.children?
    props.children = [props.children] unless isArray(props.children)
    children = [children] unless childrenIsArray
    props.children = props.children.concat(children)
  else
    props.children = children
  props





  # if this.children?
  #   this.children =
  # if isArray(value)
  #   if value.length > 0
  #     this.children ||= []
  #     this.children = this.children.concat(value)
  # else
  #   this.children ||= []
  #   this.children = this.children.concat([value])
