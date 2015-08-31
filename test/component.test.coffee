React            = require 'react'
component        = require '../component'
StyleComponent   = require '../StyleComponent'

{div,span} = DOM = React.DOM

describe 'component', ->

  it 'should be a valid react component', ->
    Thing = component 'Thing',
      render: ->
        React.DOM.div({}, 'Thing here')

    expect(Thing).to.be.aValidComponentClass()

  ###
    Create a standard Reactatron Component
  ###
  describe 'component(name, spec)', ->
    it 'should work', ->
      Button = component 'Button',
        render: ->
          div {}, 'ClickMe'
      expect(Button).to.be.aValidComponentClass()
      expect(-> Button() ).to.render('<div>ClickMe</div>')



  ###
    Shorthand for a standard Reactatron Component
  ###
  describe 'component(name, function)', ->
    it 'should work', ->
      Button = component 'Button', ->
        div {}, 'ClickMe'

      expect(-> Button() ).to.render('<div>ClickMe</div>')


  ###
    Component wrapper
  ###
  describe 'component(function)', ->
    it 'should work', ->

      Button = component ->
        div {}, 'ClickMe'

      expect(-> Button() ).to.render('<div>ClickMe</div>')











  # describe 'React.DOM.div', ->
  # #   it 'should work', ->

  # #     children = null
  # #     Test = component 'Test', ->
  # #       children = @props.children
  # #       div(@props)


  # #     expect( Test   ).to.be.aComponent()
  # #     expect( Test() ).to.be.aValidReactElement()

  # #     renderToString {}, -> Test()
  # #     expect(children).to.be(undefined)

  # #     renderToString {}, -> Test({}, div())
  # #     expect(children).to.not.be(undefined)
  # #     expect(children.type).to.eql('div')

  # #     renderToString {}, -> Test({}, div(), span())
  # #     expect(children).to.be.an(Array)
  # #     expect(children[0].type).to.eql('div')
  # #     expect(children[1].type).to.eql('span')

  # #     renderToString {}, -> Test(children:span(), div(), span())
  # #     expect(children).to.be.an(Array)
  # #     expect(children[0].type).to.eql('div')
  # #     expect(children[1].type).to.eql('span')

  # #     renderToString {}, -> Test(children:span())
  # #     expect(children).to.not.be(undefined)
  # #     expect(children.type).to.eql('span')

  # #     renderToString {}, -> Test(children:[span(), div()])
  # #     expect(children).to.be.an(Array)
  # #     expect(children[0].type).to.eql('span')
  # #     expect(children[1].type).to.eql('div')

  # #     renderToString {}, -> Test(children:span(), div())
  # #     expect(children).to.not.be(undefined)
  # #     expect(children.type).to.eql('div')


  # #     # html = renderToString {}, ->
  # #     #   Test {}, div({}, 'a'), div({},'b')

  # #     # console.log(html)

  #   it 'should work', ->
  #     expect(-> div({}, 'ClickMe') ).to.render('<div>ClickMe</div>')

















  # it 'should append children from arguments into props.children', ->
  #   expect ->
  #     div
  #       children:['A', div({}, 'B')]
  #       'C'
  #       div({},'D')
  #   .to.render('<div>C<div>D</div></div>')


  # it 'i have no idea what im testing :P', ->

  #   Z = component 'Z',
  #     render: ->
  #       div @cloneProps(), @props.children, 'Z'

  #   Y = component 'Y', (props) ->
  #     Z props, props.children, 'Y'


  #   X = component (props) ->
  #     Y props, props.children, 'X'


  #   expect ->
  #     X
  #       title: 'xxx'
  #       style:
  #         color: 'blue'
  #       'W'
  #   .to.render('<div title="xxx" style="color:blue;">WXYZ</div>')




  # describe '#withStyle', ->

  #   it 'should return a new component that wraps the original component', ->

  #     Button = DOM.button.withStyle 'Button',
  #       background: 'transparent'
  #       border: '1px solid grey'
  #       padding: '0.25em'

  #     RedButton = Button.withStyle 'RedButton',
  #       background: 'red'
  #       borderColor: 'red'

  #     BigRedButton = RedButton.withStyle 'BigRedButton',
  #       fontSize: '150%'

  #     expect( DOM.button().type   ).to.be( StyleComponent.type )
  #     expect( Button().type       ).to.be( Button.type )
  #     expect( RedButton().type    ).to.be( RedButton.type )
  #     expect( BigRedButton().type ).to.be( BigRedButton.type )

  #     expect( DOM.button.isStyledComponent   ).to.be( undefined )
  #     expect( Button.isStyledComponent       ).to.be( true )
  #     expect( RedButton.isStyledComponent    ).to.be( true )
  #     expect( BigRedButton.isStyledComponent ).to.be( true )

  #     expect( DOM.button.unstyled   ).to.be( undefined )
  #     expect( Button.unstyled       ).to.be( DOM.button )
  #     expect( RedButton.unstyled    ).to.be( DOM.button )
  #     expect( BigRedButton.unstyled ).to.be( DOM.button )

  #     expect( Button.style ).to.eql
  #       background: 'transparent'
  #       border: '1px solid grey'
  #       padding: '0.25em'


  #     expect( RedButton.style ).to.eql
  #       background: 'red'
  #       border: '1px solid grey'
  #       padding: '0.25em'
  #       borderColor: 'red'

  #     expect( BigRedButton.style ).to.eql
  #       background: 'red'
  #       border: '1px solid grey'
  #       padding: '0.25em'
  #       borderColor: 'red'
  #       fontSize: '150%'

  #     expect ->
  #       BigRedButton
  #         style:
  #           color:'blue'
  #         'PUSH'

  #     .to.render(
  #       '<button style="background:red;border:1px solid grey;padding:0.25em;border-color:red;font-size:150%;color:blue;">PUSH</button>'
  #     )






  # describe 'wrapping components', ->

  #   RootComponent = RedButton = null
  #   beforeEach ->
  #     RootComponent = (props, children...) ->
  #       {props:props, children:children}

  #     RedButton = component (props) ->
  #       props.extendStyle
  #         background: 'red'
  #       RootComponent props


  #   describe 'using functions', ->

  #     it 'should just call through', ->

  #       button = RedButton
  #         style: {color:'orange'},
  #         'Click it!'

  #       expect( button ).to.eql {
  #         props: {
  #           style: {
  #             background: "red"
  #             color:      'orange'
  #           }
  #           children: 'Click it!',
  #         }
  #         children: []
  #       }


  #       BigRedbutton = component (props) ->
  #         props.extendStyle
  #           fontSize: '120%'
  #         RedButton props

  #       button = BigRedbutton
  #         style: {color:'green'},
  #         'cancel?'

  #       expect( button ).to.eql {
  #         props: {
  #           style: {
  #             background: "red"
  #             color:      'green'
  #             fontSize: '120%'
  #           }
  #           children: 'cancel?',
  #         }
  #         children: []
  #       }


  #   describe 'using Component#withDefaultProps', ->

  #     it 'should return a function wrapping the component', ->

  #       DangerButton = RedButton.withDefaultProps
  #         title: 'warning!!'
  #         alt: 'warning :D'
  #         style:
  #           fontWeight: 'bolder'


  #       button = DangerButton
  #         style: {color:'teal'},
  #         alt: 'DONT DO IT'
  #         'DANGER'

  #       expect( button ).to.eql {
  #         props: {
  #           title: 'warning!!'
  #           alt: 'DONT DO IT'
  #           style: {
  #             background: 'red'
  #             fontWeight: 'bolder'
  #             color:      'teal'
  #           }
  #           children: 'DANGER',
  #         }
  #         children: []
  #       }





  #   describe 'using Component#wrapComponent', ->

  #     it 'should return a function wrapping the component', ->

  #       DangerButton = RedButton.wrapComponent (props) ->
  #         props.title ||= 'warning!!'
  #         props.alt   ||= 'warning :D'
  #         props.reverseExtend
  #           style:
  #             fontWeight: 'bolder'
  #         props


  #       button = DangerButton
  #         style: {color:'teal'},
  #         alt: 'DONT DO IT'
  #         'DANGER'

  #       expect( button ).to.eql {
  #         props: {
  #           title: 'warning!!'
  #           alt: 'DONT DO IT'
  #           style: {
  #             background: 'red'
  #             fontWeight: 'bolder'
  #             color:      'teal'
  #           }
  #           children: 'DANGER',
  #         }
  #         children: []
  #       }




