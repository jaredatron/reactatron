Style = require '../Style'

describe 'Style', ->

  redButton = null
  before ->
    redButton = new Style
      background: 'red'
      border: '1px solid blue'
      ':hover':
        background: 'blue'
        border: '1px solid red'

  it 'should nested merge keys that start with a colon', ->
    greenButton = redButton.merge
      background: 'green'
      ':hover':
        border: '1px solid yellow'

    expect(greenButton).to.eql
      background: 'green'
      border: '1px solid blue'
      ':hover':
        background: 'blue'
        border: '1px solid yellow'

  describe '#compute', ->

    it 'should apply optional styles depending on state like hover', ->

      expect( redButton.compute() ).to.eql
        background: 'red'
        border: '1px solid blue'

      expect( redButton.compute(hover: true) ).to.eql
        background: 'blue'
        border: '1px solid red'

