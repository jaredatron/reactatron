require './helper'

prepareProps = require '../prepareProps'

describe 'prepareProps', ->

  it 'should work the same way React does'

  it 'should set props.children to any children given as arguments', ->
    test = (args, expected) ->
      expect( prepareProps(args) ).to.eql expected

    test [                     ],   undefined
    test [{}                   ], {}
    test [{}, 'a'              ], {children:'a'      }
    test [{}, 'a','b'          ], {children:['a','b']}
    test [{children:'a'}       ], {children:'a'      }
    test [{children:['a','b']} ], {children:['a','b']}
    test [{children:'a'}, 'c'  ], {children:'c'      }
