component  = require '../component'
{div,span} = require '../DOM'

describe 'component', ->

  RootComponent = null
  beforeEach ->
    RootComponent = (props, children...) ->
      {props:props, children:children}

  it 'should work', ->

    Button = component 'Button',
      render: ->
        div {}, 'ClickMe'

    button = Button()
    expect( renderComponent(button) ).to.eql('<div>ClickMe</div>')

  describe 'wrapping components', ->

    it 'should work', ->


      RedButton = component (props) ->
        props.style.update
          background: 'red'
        RootComponent props, 'ClickMe'

      button = RedButton()
      expect( button ).to.eql {
        props: {
          style: {
            background: "red"
          }
          children: [],
        }
        children: ['ClickMe']
      }


      # RedButton = Button.withStyle
      #   background: 'red'

      # button = RedButton()
      # expect( renderComponent(button) ).to.eql('<div style="background: red;">ClickMe</div>')

      # # console.log Object.keys(React)
      # # console.log Object.keys(TestUtils)


