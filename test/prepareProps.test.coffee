prepareProps = require '../prepareProps'

describe 'prepareProps', ->

  it 'should work the same way React does'

  it 'should set props.children to any children given as arguments', ->
    child1 = {child:1}
    child2 = {child:2}


    expect( prepareProps([]) ).to.eql undefined

    expect( prepareProps([{}]) ).to.eql {}

    expect( prepareProps([{}, 'a']) ).to.eql {children:'a'}
    expect( prepareProps([{}, 'a', 'b']) ).to.eql {children:['a','b']}

    expect( prepareProps([{ }                       ]) ).to.eql {                            }
    expect( prepareProps([{ }, child1               ]) ).to.eql { children: child1           }
    expect( prepareProps([{ }, [child1]             ]) ).to.eql { children: [child1]         }
    expect( prepareProps([{ }, child1, child2       ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ }, [child1], child2     ]) ).to.eql { children: [[child1], child2] }
    expect( prepareProps([{ }, [child1], [child2]   ]) ).to.eql { children: [[child1], [child2]] }
    expect( prepareProps([{ }, [[child1], [child2]] ]) ).to.eql { children: [child1, child2] }


    expect( prepareProps([{ children: [] }                       ]) ).to.eql { children: []               }
    expect( prepareProps([{ children: [] }, child1               ]) ).to.eql { children: child1           }
    expect( prepareProps([{ children: [] }, [child1]             ]) ).to.eql { children: [child1]         }
    expect( prepareProps([{ children: [] }, child1, child2       ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: [] }, [child1], child2     ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: [] }, [child1], [child2]   ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: [] }, [[child1], [child2]] ]) ).to.eql { children: [child1, child2] }



    expect( prepareProps([{ children: child1 }                       ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, child1               ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, [child1]             ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, child1, child2       ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, [child1], child2     ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, [child1], [child2]   ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1 }, [[child1], [child2]] ]) ).to.eql { children: child1 }
