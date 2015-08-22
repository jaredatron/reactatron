Store = require '../Store'

describe 'Store', ->

  data = store = null
  beforeEach ->
    data = {}
    store = new Store data: data

  it 'should be a store', ->

    expect(store).to.be.a(Store)
    expect(store.data).to.be(data)

    expect( store.get('a') ).to.be(undefined)
    store.set('a','b')
    expect( store.get('a') ).to.equal('b')
    store.unset('a')
    expect( store.get('a') ).to.be(undefined)


  it 'should serialize complex objects', ->
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




  it 'subscriptions', ->

    store.sub()
