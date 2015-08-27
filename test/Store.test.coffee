Store = require '../Store'

describe 'Store', ->

  events = data = store = null
  beforeEach ->
    events = {
      pub: new CallLogger
    }

    store = new Store(events: events)
    store.data = data = {}

  it 'should CRUD complex objects', ->

    expect(store).to.be.a(Store)
    expect(store.data).to.be(data)

    expect( store.get('a')     ).to.be(undefined)
    expect( events.pub.calls ).to.eql([])

    expect( store.set( a: 'b' ) ).to.be(store)
    console.log(data)
    expect( events.pub.calls ).to.eql([
      ["store:change:a", {type:"set", changes:{a:'b'}}]
    ])
    expect( store.get('a')     ).to.equal('b')
    expect( store.del('a')     ).to.be(store)
    expect( store.get('a')     ).to.be(undefined)


    thing = {
      isThing: true,
      type: 'amabob',
      organs: [
        {name: 'liver', dead: false},
        {name: 'splean', dead: true},
      ]
    }
    store.set thing: thing
    expect( store.get('thing') ).to.eql(thing)
    expect( store.get('thing') ).to.not.be(thing)


  xit 'should reject non (primative|plainObject)s', ->

    Frog = -> null
    frog = new Frog

    expect( -> store.set(frog) ).to.throwException (error) ->
      expect(error).to.b.a(Error)
      expect(error.message).to.eql('oooops')




  describe '#keys', ->

    it 'should work', ->

      expect( store.keys() ).to.eql( [] )
