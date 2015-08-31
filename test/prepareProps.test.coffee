prepareProps = require '../prepareProps'

describe 'prepareProps', ->

  it 'should work', ->
    child1 = {child:1}
    child2 = {child:2}

    expect( prepareProps([                                              ]) ).to.eql undefined
    expect( prepareProps([{                     }                       ]) ).to.eql {                            }
    expect( prepareProps([{                     }, child1               ]) ).to.eql { children: child1           }
    expect( prepareProps([{                     }, [child1]             ]) ).to.eql { children: [child1]         }
    expect( prepareProps([{                     }, child1, child2       ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{                     }, [child1], child2     ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{                     }, [child1], [child2]   ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{                     }, [[child1], [child2]] ]) ).to.eql { children: [child1, child2] }


    expect( prepareProps([{ children: []        }                       ]) ).to.eql { children: []               }
    expect( prepareProps([{ children: []        }, child1               ]) ).to.eql { children: child1           }
    expect( prepareProps([{ children: []        }, [child1]             ]) ).to.eql { children: [child1]         }
    expect( prepareProps([{ children: []        }, child1, child2       ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: []        }, [child1], child2     ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: []        }, [child1], [child2]   ]) ).to.eql { children: [child1, child2] }
    expect( prepareProps([{ children: []        }, [[child1], [child2]] ]) ).to.eql { children: [child1, child2] }



    expect( prepareProps([{ children: child1    }                       ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, child1               ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, [child1]             ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, child1, child2       ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, [child1], child2     ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, [child1], [child2]   ]) ).to.eql { children: child1 }
    expect( prepareProps([{ children: child1    }, [[child1], [child2]] ]) ).to.eql { children: child1 }
