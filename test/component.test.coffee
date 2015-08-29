component  = require '../component'
{div,span} = require '../DOM'

describe 'component', ->


  it 'component(name, spec)', ->

    Button = component 'Button',
      render: ->
        div {}, 'ClickMe'

    button = Button()
    expect( renderComponent(button) ).to.eql('<div>ClickMe</div>')


  it 'component(name, function)', ->

    Button = component 'Button', ->
      div {}, 'ClickMe'

    button = Button()
    expect( renderComponent(button) ).to.eql('<div>ClickMe</div>')


  it 'component(function)', ->

    Button = component ->
      div {}, 'ClickMe'

    button = Button()
    expect( renderComponent(button) ).to.eql('<div>ClickMe</div>')

  it 'composing should take children and style into account', ->

    Z = component 'Z',
      render: ->
        div @cloneProps(), 'Z'

    Y = component 'Y', (props) ->
      Z props, 'Y'


    X = component (props) ->
      Y props, 'X'


    tree = X
      title: 'xxx'
      style:
        color: 'blue'
      'W'

    expect( renderComponent(tree) ).to.eql('<div title="xxx" style="color:blue;">WXYZ</div>')




  describe 'wrapping components', ->

    RootComponent = RedButton = null
    beforeEach ->
      RootComponent = (props, children...) ->
        {props:props, children:children}

      RedButton = component (props) ->
        props.style.update
          background: 'red'
        RootComponent props


    describe 'using functions', ->

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


    describe 'using Component#withDefaultProps', ->

      it 'should return a function wrapping the component', ->

        DangerButton = RedButton.withDefaultProps
          title: 'warning!!'
          alt: 'warning :D'
          style:
            fontWeight: 'bolder'


        button = DangerButton
          style: {color:'teal'},
          alt: 'warning D:'
          'DANGER'

        expect( button ).to.eql {
          props: {
            title: 'warning!!'
            alt: 'warning D:'
            style: {
              background: 'red'
              fontWeight: 'bolder'
              color:      'teal'
            }
            children: ['DANGER'],
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




