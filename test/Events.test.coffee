require './helper'

Events = require '../Events'

describe 'Events', ->

  events = null
  beforeEach ->
    events = new Events


  it 'async pub sub', (done) ->

    onAll = new CallLogger
    onJump = new CallLogger
    onLeap = new CallLogger

    expect(onAll.callCount ).to.be(0)
    expect(onJump.callCount).to.be(0)
    expect(onLeap.callCount).to.be(0)

    events.sub '*', onAll
    events.sub 'jump', onJump
    events.sub ['jump','leap'], onLeap

    events.pub 'jump', '1f'
    events.pub 'jump', '2f'
    expect(onAll.callCount ).to.be(0)
    expect(onJump.callCount).to.be(0)
    expect(onLeap.callCount).to.be(0)

    setTimeout ->
      expect(onAll.callCount ).to.be(2)
      expect(onJump.callCount).to.be(2)
      expect(onLeap.callCount).to.be(2)

      expect(onAll.calls).to.eql [
        ['jump', '1f']
        ['jump', '2f']
      ]
      expect(onJump.calls).to.eql [
        ['jump', '1f']
        ['jump', '2f']
      ]
      expect(onLeap.calls).to.eql [
        ['jump', '1f']
        ['jump', '2f']
      ]



      events.pub 'leap', '30f'
      expect(onAll.callCount ).to.be(2)
      expect(onJump.callCount).to.be(2)
      expect(onLeap.callCount).to.be(2)

      setTimeout ->
        expect(onAll.callCount ).to.be(3)
        expect(onJump.callCount).to.be(2)
        expect(onLeap.callCount).to.be(3)

        expect(onAll.calls).to.eql [
          ['jump', '1f']
          ['jump', '2f']
          ['leap', '30f']
        ]
        expect(onJump.calls).to.eql [
          ['jump', '1f']
          ['jump', '2f']
        ]
        expect(onLeap.calls).to.eql [
          ['jump', '1f']
          ['jump', '2f']
          ['leap', '30f']
        ]



        events.pub 'scream', '4db'
        expect(onAll.callCount ).to.be(3)
        expect(onJump.callCount).to.be(2)
        expect(onLeap.callCount).to.be(3)

        setTimeout ->
          expect(onAll.callCount ).to.be(4)
          expect(onJump.callCount).to.be(2)
          expect(onLeap.callCount).to.be(3)

          expect(onAll.calls).to.eql [
            ['jump', '1f']
            ['jump', '2f']
            ['leap', '30f']
            ['scream', '4db']
          ]
          expect(onJump.calls).to.eql [
            ['jump', '1f']
            ['jump', '2f']
          ]
          expect(onLeap.calls).to.eql [
            ['jump', '1f']
            ['jump', '2f']
            ['leap', '30f']
          ]


          done()


  it 'partial unsub', (done) ->
    counter = new Counter

    events.sub ['jump','leap'], counter

    events.pub 'jump', 42
    events.pub 'leap', 89
    expect(counter.value).to.be(0)

    setTimeout ->
      expect(counter.value).to.be(2)
      events.unsub 'leap', counter
      events.pub 'jump', 33
      events.pub 'leap', 72
      expect(counter.value).to.be(2)

      setTimeout ->
        expect(counter.value).to.be(3)
        done()


  it 'double subscriptions', (done) ->
    counter = new Counter

    events.sub 'jump', counter
    events.sub 'jump', counter

    events.pub 'jump'
    expect(counter.value).to.be(0)

    setTimeout ->
      expect(counter.value).to.be(1)
      events.unsub 'jump', counter
      events.pub 'jump'

      setTimeout ->
        expect(counter.value).to.be(1)
        done()


  # xit 'RegExp subscriptions', ->

  #   events.sub /^jump|leap$/, counter

  #   expect( counter.value ).to.be(0)

  #   events.pub('fall')
  #   expect( counter.value ).to.be(0)

  #   events.pub('jump')
  #   expect( counter.value ).to.be(1)

  #   events.pub('leap')
  #   expect( counter.value ).to.be(2)

  #   events.unsub /^jump|leap$/, counter

  #   events.pub('leap')
  #   expect( counter.value ).to.be(2)

  it 'all subscriptions', (done) ->
    counter = new Counter
    events.sub '*', counter

    events.pub 'a'
    events.pub 'b'
    events.pub 'c'

    expect( counter.value ).to.be(0)
    setTimeout ->
      expect(counter.value).to.be(3)
      done()

  xit 'should fire done callback if given to pub', (done) ->
    null

