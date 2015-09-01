require './helper'

mergeChildren = require '../mergeChildren'

describe 'mergeChildren', ->

  it 'should work', ->
    child1 = {child:1}
    child2 = {child:2}

    expect( mergeChildren(                         ) ).to.eql undefined
    expect( mergeChildren( [],           undefined ) ).to.eql undefined
    expect( mergeChildren( undefined,    []        ) ).to.eql undefined
    expect( mergeChildren( child1,       undefined ) ).to.eql child1
    expect( mergeChildren( undefined,    child1    ) ).to.eql child1
    expect( mergeChildren( [child1],     undefined ) ).to.eql child1
    expect( mergeChildren( undefined,    [child1]  ) ).to.eql child1
    expect( mergeChildren( child1,       []        ) ).to.eql child1
    expect( mergeChildren( [],           child1    ) ).to.eql child1
    expect( mergeChildren( child1,       child2    ) ).to.eql [child1, child2]
    expect( mergeChildren( [child1],     child2    ) ).to.eql [child1, child2]
    expect( mergeChildren( child1,       [child2]  ) ).to.eql [child1, child2]

