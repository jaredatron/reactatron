App = require '../App'

describe 'App', ->

  app = storeData = null
  beforeEach ->
    storeData = {}
    app = new App
      storeData: storeData

  it 'pub sub', ->

    loginCounter = new Counter

    app.sub 'login', loginCounter

    expect(loginCounter.value).to.be(0)
    app.pub 'login'
    expect(loginCounter.value).to.be(1)

    app.unsub 'login', loginCounter
    app.pub 'login'
    expect(loginCounter.value).to.be(1)


  it 'store', ->

    current_user = { name: 'Thomas' }

    events = []
    app.sub /.*/, (event, payload) ->
      events.push [event, payload]

    app.set 'current_user', current_user
    expect( app.get('current_user') ).to.eql(current_user)
    expect( app.get('current_user') ).to.not.be(current_user)
    expect( events ).to.eql([
      [ 'store:change', 'current_user' ],
      [ 'store:change:current_user', undefined ],
    ])

    console.log(events)
