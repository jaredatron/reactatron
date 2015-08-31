{div} = DOM = require '../DOM'

StyleComponent = require '../StyleComponent'

describe 'DOM', ->

  it 'should work as expected', ->

    expect ->
      div()
    .to.render('<div></div>')

    expect ->
      div
        title: 'frog'
        style:
          color: 'red'
        'boosh'
    .to.render('<div title="frog" style="color:red;">boosh</div>')


  it 'should always render a StyleComponent around the root component', ->
    tree = div()
    expect( tree.type ).to.eql( StyleComponent.type )

    tree = div style: {}
    expect( tree.type ).to.eql( StyleComponent.type )


    tree = div
      style:
        color: 'red'
        ':hover':
          color: 'green
          '

    expect( tree.type ).to.eql( StyleComponent.type )



