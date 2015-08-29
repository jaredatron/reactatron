component  = require '../component'
{div,span} = require '../DOM'

describe 'component', ->

  it 'should work', ->

    Button = component 'Button',
      render: ->
        div {}, 'ClickMe'

    button = Button()
    expect( renderComponent(button) ).to.eql('<div>ClickMe</div>')



  describe 'wrapping components', ->

    RootComponent = RedButton = null
    beforeEach ->
      RootComponent = (props, children...) ->
        {props:props, children:children}

      RedButton = component (props) ->
        props.style.update
          background: 'red'
        RootComponent props


    describe 'useing functions', ->

      it 'should just call through', ->

        button = RedButton
          style: {color:'orange'},
          'Click it!'

        expect( button ).to.eql {
          props: {
            style: {
              background: "red"
              color:      'orange'
            }
            children: ['Click it!'],
          }
          children: []
        }


        BigRedbutton = component (props) ->
          props.style.update
            fontSize: '120%'
          RedButton props

        button = BigRedbutton
          style: {color:'green'},
          'cancel?'

        expect( button ).to.eql {
          props: {
            style: {
              background: "red"
              color:      'green'
              fontSize: '120%'
            }
            children: ['cancel?'],
          }
          children: []
        }


    describe 'using Component#withStyle', ->

      it 'should return a function wrapping the component', ->

        BigRedButton = RedButton.withStyle
          fontSize: '120%'

        button = BigRedButton
          style: {color:'yellow'},
          'omg u sure?'

        expect( button ).to.eql {
          props: {
            style: {
              background: 'red'
              fontSize:   '120%'
              color:      'yellow'
            }
            children: ['omg u sure?'],
          }
          children: []
        }




