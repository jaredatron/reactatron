Props = require '../Props'
Style = require '../Style'

describe 'Props', ->

  style1 = style2 = child1 = child2 = null
  beforeEach ->
    style1 = {fontSize: '1px',                ':hover':{left: '1px'             }}
    style2 = {                 margin: '2em', ':hover':{            right: '2px'}}
    child1 = {child:1}
    child2 = {child:2}

  describe '#constructor', ->

    it 'should not require new', ->
      expect( new Props ).to.be.a(Props)
      expect( Props() ).to.be.a(Props)

    it 'should return the given object if it is an instanceof Props', ->
      props = new Props
      expect(props           ).to.be.a(Props)
      expect(    Props(props)).to.be(props)
      expect(new Props(props)).to.be(props)

    it 'should extend itself with the props given object, merging style ', ->

      child = {child:1}

      props =
        a: 1
        b: 1
        style:
          sA: 1
          sB: 1
          ':hover':
            hA: 1
            hB: 1
        children: child

      p1 = Props(props)

      expect(p1).to.eql(props)
      expect(p1).to.not.be(props)
      expect(p1.style).to.eql(props.style)
      expect(p1.children).to.be(child)




  describe '#extend', ->

    it 'should merge style', ->
      mergeStyle = Style(style1).merge(style2)
      props = Props()
      expect('style' of props).to.be(false)
      props.extend style: style1
      expect(props.style).to.be(style1)
      props.extend style: style2
      expect(props.style).to.not.be(style1)
      expect(props.style).to.not.be(style2)
      expect(props.style).to.eql mergeStyle


    it 'should merge children', ->
      props = Props()
      expect(props.children).to.be(undefined)

      props = Props children: child1
      expect(props.children).to.be(child1)

      props = Props children: [child1]
      expect(props.children).to.be.a(Array)
      expect(props.children.length).to.be(1)
      expect(props.children[0]).to.be(child1)

      props = Props()
      expect(props.children).to.be(undefined)
      props.extend children: child1
      expect(props.children).to.be(child1)
      props.extend children: child2
      expect(props.children).to.eql([child1,child2])

  describe '#appendChildren', ->
    it 'should append the given children and return this', ->
      props = Props().appendChildren()
      expect(props.children).to.be(undefined)

      props = Props().appendChildren(child2)
      expect(props.children).to.be(child2)

      props = Props(children: child1).appendChildren()
      expect(props.children).to.be(child1)

      props = Props(children: child1).appendChildren(child2)
      expect(props.children).to.eql([child1, child2])

      props = Props(children:[child1]).appendChildren(child2)
      expect(props.children).to.eql([child1, child2])

      props = Props(children:[child1]).appendChildren([child2])
      expect(props.children).to.eql([child1, child2])


