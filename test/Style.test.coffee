Style = require '../Style'

describe 'Style', ->


  describe '#constructor', ->
    it 'should not require new', ->
      expect( new Style ).to.be.a(Style)
      expect( Style() ).to.be.a(Style)

    it 'should merge all style arguments', ->
      style = new Style({a:1},{b:2},{a:3,c:3})
      expect(style).to.be.a(Style)
      expect(style).to.eql a: 3, b:2, c: 3

  describe '#replace', ->
    it 'should replace the existing style object with the given properties', ->
      style = new Style a: 1, b: 1
      expect(style).to.eql a: 1, b: 1
      style.replace b: 2, c: 2
      expect(style).to.eql b: 2, c: 2


  describe '#update', ->
    it 'should deep merge objects 1 level deep', ->
      style = new Style
      style.update(
        {a:1,           d:{e:1, f:1,      h:{i:1        }}}
        {     b:2,      d:{          g:2, h:{    j:2    }}}
        {a:3,      c:3, d:{     f:3,      h:{        k:3}}}
      )

      expect(style).to.eql(
        a: 3, b:2, c:3, d:{e:1, f:3, g:2, h:{k:3}}
      )

    it 'should merge the given styles into the current styles', ->
      a = new Style({a:1},{b:1}      )
      b = a.update( {a:2},      {c:3})
      expect(b).to.be(a)
      expect(a).to.eql({a:2, b:1, c:3})

  describe '#reverseUpdate', ->
    it 'should update the current style object the reverseMerge results', ->
      a = new Style(      {a:1},{b:1}      )
      b = a.reverseUpdate({a:2},      {c:3})
      expect(b).to.be(a)
      expect(a).to.eql({a:1, b:1, c:3})

  describe '#merge', ->
    it 'should return a clone of the left style merge with the right style', ->
      a = new Style({a:1},{b:1}      )
      b = a.merge(  {a:2},      {c:3})
      expect(b).to.not.be(a)
      expect(a).to.eql({a:1, b:1})
      expect(b).to.eql({a:2, b:1, c:3})

  describe '#reverseMerge', ->
    it 'should return a clone of the left style merge with the right style', ->
      a = new Style(       {a:1},{b:1}      )
      b = a.reverseMerge(  {a:2},      {c:3})
      expect(b).to.not.be(a)
      expect(a).to.eql({a:1, b:1})
      expect(b).to.eql({a:1, b:1, c:3})

  describe '#compute', ->
    it 'should set undefined or null values to empty Strings'



  it 'should work like this', ->
    redButton = new Style
      background: 'red'
      border: '1px solid blue'
      ':hover':
        background: 'blue'
        border: '1px solid red'

    greenButton = redButton.merge
      background: 'green'
      ':hover':
        border: '1px solid yellow'


    bigGreenButton = greenButton.merge
      fontSize: '134%'


    expect(bigGreenButton).to.eql
      background: 'green'
      border: '1px solid blue'
      fontSize: '134%'
      ':hover':
        background: 'blue'
        border: '1px solid yellow'



  describe '#compute', ->

    it 'should apply optional styles depending on state like hover', ->
      redButton = new Style
        background: 'red'
        border: '1px solid blue'
        ':hover':
          background: 'blue'
          border: '1px solid red'

        ':active':
          background: 'green'
          border: '1px solid green'

      expect( redButton.compute({}) ).to.eql
        background: 'red'
        border: '1px solid blue'

      expect( redButton.compute(hover: true) ).to.eql
        background: 'blue'
        border: '1px solid red'

      expect( redButton.compute(active: true) ).to.eql
        background: 'green'
        border: '1px solid green'

      expect( redButton.compute(hover: true, active: true) ).to.eql
        background: 'green'
        border: '1px solid green'



