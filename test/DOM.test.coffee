{div} = DOM = require '../DOM'

StyleComponent = require '../StyleComponent'

describe 'DOM', ->

  it 'should work as expected', ->
    tree = div()
    expect( renderComponent(tree) ).to.eql('<div></div>')

    tree = div
      title: 'frog'
      style:
        color: 'red'
      'boosh'
    expect( renderComponent(tree) ).to.eql('<div title="frog" style="color:red;">boosh</div>')

  it 'should append children from arguments into props.children', ->
    tree = div
      children:['A', div({}, 'B')]
      'C'
      div({},'D')

    expect( renderComponent(tree) ).to.eql(
      '<div>A<div>B</div>C<div>D</div></div>'
    )


  describe 'when given styles that need controlling', ->

    it 'should render a StyleComponent around the root component', ->
      tree = div()
      expect( tree.type ).to.eql( 'div' )

      tree = div style: {}
      expect( tree.type ).to.eql( 'div' )


      tree = div
        style:
          color: 'red'
          ':hover':
            color: 'green
            '

      expect( tree.type ).to.eql( StyleComponent.type )



