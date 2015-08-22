LocationPlugin = require '../LocationPlugin'

describe 'LocationPlugin', ->

  locationPlugin = app = null

  beforeEach ->
    LocationPlugin.prototype.window = {
      addEventListener: new CallLogger
      removeEventListener: new CallLogger
      location: {
        pathname: '/',
        search: '',
      }
    }

    app = {
      set: new CallLogger
    }
    locationPlugin = new LocationPlugin(app, {})

  it 'init', ->
    expect( app.locationFor ).to.be( locationPlugin.for )
    expect( app.setLocation ).to.be( locationPlugin.set )
    expect( app.setPath     ).to.be( locationPlugin.setPath )
    expect( app.setParams   ).to.be( locationPlugin.setParams )
    expect( app.locationFor ).to.be( locationPlugin.for )
    expect(app.set.calls).to.eql([
      ['location', {path: '/', params: {}}]
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

      expect(app.set.calls).to.eql([
        ['location', {path: '/', params: {}}]
      ])
      locationPlugin.update()
      expect(app.set.calls).to.eql([
        ['location', {path: '/', params: {}}],
        ['location', {path: '/', params: {}}]
      ])

      LocationPlugin.prototype.window.location = {
        pathname: '/login',
        search: '?username=Julia+Sanders&password=12345god',
      }

      locationPlugin.update()
      expect(app.set.calls).to.eql([
        ['location', {path: '/', params: {}}],
        ['location', {path: '/', params: {}}]
        ['location', {path: '/login', params: {
          password: '12345god',
          username: 'Julia+Sanders'
        }}]
      ])


  describe '#for', ->
    it 'should generate location strings'
