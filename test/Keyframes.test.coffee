require './helper'

Keyframes = require '../Keyframes'

describe 'Keyframes', ->

  it 'should work', ->

    bounce = new Keyframes 'bounce',
      'from, 20%, 53%, 80%, to':
        animationTimingFunction: 'cubic-bezier(0.215, 0.610, 0.355, 1.000)'
        transform: 'translate3d(0,0,0)'

      '40%, 43%':
        animationTimingFunction: 'cubic-bezier(0.755, 0.050, 0.855, 0.060)'
        transform: 'translate3d(0, -30px, 0)'

      '70%':
        animationTimingFunction: 'cubic-bezier(0.755, 0.050, 0.855, 0.060)'
        transform: 'translate3d(0, -15px, 0)'

      '90%':
        transform: 'translate3d(0,-4px,0)'

    expect( bounce.toRule() ).to.eql """
@keyframes bounce {
  from, 20%, 53%, 80%, to {
    -webkit-animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    -webkit-transform: translate3d(0,0,0);
    transform: translate3d(0,0,0);
  }
  40%, 43% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -30px, 0);
    transform: translate3d(0, -30px, 0);
  }
  70% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -15px, 0);
    transform: translate3d(0, -15px, 0);
  }
  90% {
    -webkit-transform: translate3d(0,-4px,0);
    transform: translate3d(0,-4px,0);
  }
}

"""
