App = require '../App'

describe 'App', ->

  app = data = null
  beforeEach ->
    app = new App
    app.document = {body: {}}
    app.store.data = data = {}
    app.render = new CallLogger

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


  describe '#render', ->
    # we need to pull in the react test tools for this one
    xit 'should render the rootComponent', ->
      app.render()
      expect(app.rootComponent).to.be.eql({})

  it 'should start and stop the plugins', ->
    testPlugin =
      start: new Counter
      stop: new Counter
    app.plugins.push testPlugin
    app.start()
    expect(testPlugin.start.value).to.be(1)
    app.stop()
    expect(testPlugin.stop.value).to.be(1)


  describe '#stop', ->
    it 'should delete rootComponent and DOMNode'
