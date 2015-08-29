component  = require '../component'
{div,span} = DOM = require '../DOM'

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

  it 'should append children from arguments into props.children', ->
    tree = div
      children:['A', div({}, 'B')]
      'C'
      div({},'D')

    expect( renderComponent(tree) ).to.eql(
      '<div>A<div>B</div>C<div>D</div></div>'
    )


  it 'i have no idea what im testing :P', ->

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




  describe '#withStyle', ->

    it 'should return a new component that wraps the original component', ->

      # Button = component 'Button',
      #   defaultStyle:
      #     background: 'transparent'
      #     padding: '0.25em'

      #   render: ->
      #     div @cloneProps()

      Button = DOM.button.withStyle 'Button',
        background: 'transparent'
        border: '1px solid grey'
        padding: '0.25em'

      # console.log('Button.type', Button.type)
      # console.log('isElement', isElement(Button.type))
      # console.log('isDOMComponent', isDOMComponent(Button.type))
      # console.log('isCompositeComponent', isCompositeComponent(Button.type))
      # console.log('isCompositeComponentElement', isCompositeComponentElement(Button.type))

      RedButton = Button.withStyle 'RedButton',
        background: 'red'
        borderColor: 'red'

      BigRedButton = RedButton.withStyle 'BigRedButton',
        fontSize: '150%'

      button = BigRedButton style: {color:'blue'}, 'PUSH'

      expect( renderComponent(button) ).to.eql(
        '<button style="background:red;border:1px solid grey;padding:0.25em;border-color:red;font-size:150%;color:blue;">PUSH</button>'
      )






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




