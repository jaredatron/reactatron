Events = require '../Events'

describe 'Events', ->

  events = null
  beforeEach ->
    events = new Events


  it 'simple pub sub', ->
    counter = new Counter

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
    counter = new Counter

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
    counter = new Counter

    expect(counter.value).to.be(0)

    events.sub 'jump', counter
    events.sub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(2)

    events.unsub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(2)


  it 'RegExp subscriptions', ->
    counter = new Counter

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
