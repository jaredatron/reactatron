Events = require '../Events'

describe 'Events', ->

  events = null
  beforeEach ->
    events = new Events




  it 'pub sub', ->

    handler1 = CountingHandler()
    handler2 = CountingHandler()
    handler3 = CountingHandler()
    handler4 = CountingHandler()

    events.sub 'jump', handler1
    events.sub 'jump', handler2

    events.pub 'jump', 14

    expect(handler1.calls).to.eql([['jump', 14]])
    expect(handler1.callCount).to.be(1)
    expect(handler2.callCount).to.be(1)
    expect(handler3.callCount).to.be(0)
    expect(handler4.callCount).to.be(0)

    events.unsub 'jump', handler2

    events.pub 'jump', 15

    expect(handler1.callCount).to.be(2)
    expect(handler2.callCount).to.be(1)
    expect(handler3.callCount).to.be(0)
    expect(handler4.callCount).to.be(0)


    # events.unsub 'jump', handler1
    # expect( events.subscriptions.jump ).to.eql( [handler3] )
    # expect( 'jump' of events.subscriptions ).to.be(false)
