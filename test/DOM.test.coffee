DOM = require '../DOM'

StyleComponent = require '../StyleComponent'

describe 'DOM', ->

  it 'should work as expected', ->
    tree = DOM.div()
    expect( renderComponent(tree) ).to.eql('<div></div>')

    tree = DOM.div
      title: 'frog'
      style:
        color: 'red'
      'boosh'
    expect( renderComponent(tree) ).to.eql('<div title="frog" style="color:red;">boosh</div>')

  describe 'when given styles that need controlling', ->

    it 'should render a StyleComponent around the root component', ->
      tree = DOM.div()
      expect( tree.type ).to.eql( 'div' )

      tree = DOM.div style: {}
      expect( tree.type ).to.eql( 'div' )


      tree = DOM.div
        style:
          color: 'red'
          ':hover':
            color: 'green
            '

      expect( tree.type ).to.eql( StyleComponent.type )



