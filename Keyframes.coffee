hyphenateStyleName = require 'react/lib/hyphenateStyleName'

module.exports = class Keyframes
  constructor: (name, spec) ->
    @name = name
    @spec = spec

  toRule: ->
    css = "@keyframes #{@name} {\n"
    for frame, style of @spec
      css += "  #{frame} {\n"
      for name, value of style
        name = hyphenateStyleName(name)
        css += "    -webkit-#{name}: #{value};\n"
        css += "    #{name}: #{value};\n"
      css += "  }\n"
    css += "}\n"
    css





# bounce = new Keyframes 'bounce',
#   'from, 20%, 53%, 80%, to':
#     animationTimingFunction: 'cubic-bezier(0.215, 0.610, 0.355, 1.000)'
#     transform: 'translate3d(0,0,0)'

#   '40%, 43%':
#     animationTimingFunction: 'cubic-bezier(0.755, 0.050, 0.855, 0.060)'
#     transform: 'translate3d(0, -30px, 0)'

#   '70%':
#     animationTimingFunction: 'cubic-bezier(0.755, 0.050, 0.855, 0.060)'
#     transform: 'translate3d(0, -15px, 0)'

#   '90%':
#     transform: 'translate3d(0,-4px,0)'





# @keyframes bounce {
#   from, 20%, 53%, 80%, to {
#     -webkit-animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
#     animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
#     -webkit-transform: translate3d(0,0,0);
#     transform: translate3d(0,0,0);
#   }

#   40%, 43% {
#     -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
#     animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
#     -webkit-transform: translate3d(0, -30px, 0);
#     transform: translate3d(0, -30px, 0);
#   }

#   70% {
#     -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
#     animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
#     -webkit-transform: translate3d(0, -15px, 0);
#     transform: translate3d(0, -15px, 0);
#   }

#   90% {
#     -webkit-transform: translate3d(0,-4px,0);
#     transform: translate3d(0,-4px,0);
#   }
# }

# # var style = document.createElement('style');
# # style.type = 'text/css';
# # style.innerHTML = 'body {}';
# # document.getElementsByTagName('head')[0].appendChild(style);
# # var stylesheet = document.styleSheets[document.styleSheets.length-1];
# # rule = ''+
# # '@keyframes spinIt {\n'+
# # '    100% {\n'+
# # '        transform: rotate(A_DYNAMIC_VALUE);\n'+
# # '    }\n'+
# # '}\n';
# # stylesheet.insertRule(rule, stylesheet.rules.length);







# # we need to make an animation library entierly in JS :D
