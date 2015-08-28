LocationPlugin = require '../LocationPlugin'

describe 'LocationPlugin', ->

  locationPlugin = app = window = null

  beforeEach ->
    window = new FakeWindow;

    app = {
      set: new CallLogger
    }
    locationPlugin = new LocationPlugin( window: window )
    locationPlugin.app = app
    locationPlugin.init()

  it 'init', ->
    expect( app.locationFor ).to.be( locationPlugin.for )
    expect( app.setLocation ).to.be( locationPlugin.set )
    expect( app.setPath     ).to.be( locationPlugin.setPath )
    expect( app.setParams   ).to.be( locationPlugin.setParams )
    expect( app.locationFor ).to.be( locationPlugin.for )
    expect(app.set.calls).to.eql([
      [ { location: { path: '/', params: {} } } ]
    ])

  it 'start and stop should add and remove evner listeners', ->
    expect(locationPlugin.window.addEventListener.calls).to.eql([])
    expect(locationPlugin.window.removeEventListener.calls).to.eql([])
    locationPlugin.start()
    expect(locationPlugin.window.addEventListener.calls).to.eql([['popstate', locationPlugin.update]])
    expect(locationPlugin.window.removeEventListener.calls).to.eql([])
    locationPlugin.stop()
    expect(locationPlugin.window.addEventListener.calls).to.eql([['popstate', locationPlugin.update]])
    expect(locationPlugin.window.removeEventListener.calls).to.eql([['popstate', locationPlugin.update]])


  describe '#update', ->

    it 'should set "location"', ->

      console.log(app.set.calls)
      expect(app.set.calls).to.eql([
        [ { location: {path: '/', params: {}}} ]
      ])
      locationPlugin.update()
      expect(app.set.calls).to.eql([
        [ { location: {path: '/', params: {}}} ],
        [ { location: {path: '/', params: {}}} ]
      ])

      locationPlugin.window.location = {
        pathname: '/login',
        search: '?username=Julia+Sanders&password=12345god',
      }

      locationPlugin.update()
      expect(app.set.calls).to.eql([
        [{ location: {path: '/', params: {}}}],
        [{ location: {path: '/', params: {}}}],
        [{ location: {path: '/login', params: {
          password: '12345god',
          username: 'Julia+Sanders'
        }}}]
      ])


  describe '#for', ->
    it 'should generate location strings'
