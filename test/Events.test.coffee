Events = require '../Events'

describe 'Events', ->

  events = counter = null
  beforeEach ->
    events = new Events
    counter = new Counter

  it 'simple pub sub', ->

    expect(counter.value).to.be(0)

    events.sub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(1)

    events.pub 'jump'
    expect(counter.value).to.be(2)

    events.pub 'jump'
    expect(counter.value).to.be(3)

    events.unsub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(3)

  it 'partial unsub', ->

    expect(counter.value).to.be(0)

    events.sub ['jump','leap'], counter

    events.pub 'jump'
    expect(counter.value).to.be(1)

    events.pub 'leap'
    expect(counter.value).to.be(2)

    events.unsub 'leap', counter

    events.pub 'jump'
    expect(counter.value).to.be(3)

    events.pub 'leap'
    expect(counter.value).to.be(3)

  it 'double subscriptions', ->

    expect(counter.value).to.be(0)

    events.sub 'jump', counter
    events.sub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(2)

    events.unsub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(2)


  it 'RegExp subscriptions', ->

    events.sub /^jump|leap$/, counter

    expect( counter.value ).to.be(0)

    events.pub('fall')
    expect( counter.value ).to.be(0)

    events.pub('jump')
    expect( counter.value ).to.be(1)

    events.pub('leap')
    expect( counter.value ).to.be(2)

    events.unsub /^jump|leap$/, counter

    events.pub('leap')
    expect( counter.value ).to.be(2)

  it 'glob subscriptions', ->
    events.sub /.*/, counter

    events.pub 'a'
    events.pub 'b'
    events.pub 'c'

    expect( counter.value ).to.be(3)
