{div} = DOM = require '../DOM'

StyleComponent = require '../StyleComponent'

describe 'DOM', ->

  app = {}

  it 'should work as expected', ->
    html = renderToString app, ->
      div()
    expect( html ).to.eql('<div></div>')

    html = renderToString app, ->
      div
        title: 'frog'
        style:
          color: 'red'
        'boosh'
    expect( html ).to.eql('<div title="frog" style="color:red;">boosh</div>')

  it 'should append children from arguments into props.children', ->
    html = renderToString app, ->
      div
        children:['A', div({}, 'B')]
        'C'
        div({},'D')

    expect( html ).to.eql(
      '<div>A<div>B</div>C<div>D</div></div>'
    )


  describe 'when given styles that need controlling', ->

    it 'should render a StyleComponent around the root component', ->
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



