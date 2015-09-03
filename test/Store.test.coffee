require './helper'

Store = require '../Store'

describe 'Store', ->

  events = data = store = null
  beforeEach ->
    events = {
      pub: new CallLogger
    }

    data = {}
    store = new Store
      events: events,
      prefix: 'test/'
      data: data

  it 'should CRUD complex objects', ->

    expect(store).to.be.a(Store)
    expect(store.data).to.be(data)

    expect( store.get('a') ).to.be(undefined)
    expect( events.pub.calls ).to.eql([])

    expect( store.set( a: 'b' ) ).to.be(store)
    expect( events.pub.calls ).to.eql([
      ["store:change:a", 'a']
    ])
    expect( store.get('a') ).to.equal('b')
    expect( store.del('a') ).to.be(store)
    expect( store.get('a') ).to.be(undefined)


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

      store.set a: 1, b: 2
      expect( store.keys() ).to.eql( ['a','b'] )

      store.del 'a'
      expect( store.keys() ).to.eql( ['b'] )

      store.set c:3, d:undefined,e:5
      expect( store.keys() ).to.eql( ['b','c','e'] )

  describe '#clear', ->

    it 'should work', ->

      expect( store.keys() ).to.eql( [] )

      store.set a: 1, b: 2
      expect( store.keys() ).to.eql( ['a','b'] )

      store.clear()
      expect( store.keys() ).to.eql( [] )


  describe '#expire', ->

    describe 'when given a time <= now', ->
      it 'should delete the key immediately', ->
        store.set searchResults: 'none'
        expect( store.get('searchResults') ).to.be('none')
        store.expire searchResults: Date.now()
        expect( store.get('searchResults') ).to.be(undefined)

    it 'should call setTimeout', (done) ->

      now = Date.now()
      store._now = -> now

      expect( store.keys()               ).to.eql([])
      expect( store.get('searchResults') ).to.be(undefined)

      store.set searchResults: 'none'
      expect( store.get('searchResults') ).to.be('none')

      store.expire searchResults: now + 10 # in 10 miliseconds
      expect( store.get('searchResults') ).to.be('none')

      delay 5, ->
        expect( store.get('searchResults') ).to.be('none')

        delay 5, ->
          expect( store.get('searchResults') ).to.be(undefined)
          done()

