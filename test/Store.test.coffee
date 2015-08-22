Store = require '../Store'

describe 'Store', ->

  events = data = store = null
  beforeEach ->
    events = {}
    events.emit = (event, payload) ->
      events.emit.calls.push([event,payload])
    events.emit.calls = []

    store = new Store(events)
    store.data = data = {}

  it 'should CRUD complex objects', ->

    expect(store).to.be.a(Store)
    expect(store.data).to.be(data)

    expect( store.get('a')     ).to.be(undefined)
    expect( events.emit.calls ).to.eql([])

    expect( store.set('a','b') ).to.be(store)
    expect( events.emit.calls ).to.eql([
      ["store:change","a"],
      ["store:change:key",undefined]
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
    store.set('thing',thing)
    expect( store.get('thing') ).to.eql(thing)
    expect( store.get('thing') ).to.not.be(thing)


  xit 'should reject non (primative|plainObject)s', ->

    Frog = -> null
    frog = new Frog

    expect( -> store.set(frog) ).to.throwException (error) ->
      expect(error).to.b.a(Error)
      expect(error.message).to.eql('oooops')



