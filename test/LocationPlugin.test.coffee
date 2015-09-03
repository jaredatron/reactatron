require './helper'

Location = require '../Location'
LocationPlugin = require '../LocationPlugin'

describe 'LocationPlugin', ->

  window = app = null

  beforeEach ->
    window = new FakeWindow
    app =
      set: new CallLogger
      sub: new CallLogger
      window: window

    LocationPlugin(app)


  it 'should hookup the given app to a new Location', ->

    expect( app.location        ).to.be.a( Location )
    expect( app.locationFor     ).to.be.a('function')
    expect( app.updateLocation  ).to.be.a('function')
    expect( app.setLocation     ).to.be.a('function')
    expect( app.setPath         ).to.be.a('function')
    expect( app.setParams       ).to.be.a('function')
    expect( app.clearHash       ).to.be.a('function')


    expect( window.addEventListener.callCount    ).to.be(0)
    expect( window.removeEventListener.callCount ).to.be(0)
    expect( app.set.callCount ).to.be(0)
    expect( app.sub.callCount ).to.eql(2)


    [start, stop] = app.sub.calls
    expect( start[0] ).to.eql 'start'

    expect( stop[0] ).to.eql 'stop'


    expect( app.location.path   ).to.eql '/'
    expect( app.location.params ).to.eql {}

    window.location.pathname = '/posts'
    window.location.search   = '?order=desc'
    start[1]() # pub 'start'
    expect( window.addEventListener.callCount ).to.be(1)
    expect( app.location.path   ).to.eql '/posts'
    expect( app.location.params ).to.eql order: 'desc'

    window.location.pathname = '/login'
    window.location.search   = '?username=Julia+Sanders&password=12345god'
    window.addEventListener.calls[0][1]() # simulate popstate
    expect( app.location.path   ).to.eql '/login'
    expect( app.location.params ).to.eql password: '12345god', username: 'Julia+Sanders'


first = (a) -> a[0]

  # it 'init', ->
  #   expect( app.locationFor ).to.be( undefined )
  #   expect( app.setLocation ).to.be( undefined )
  #   expect( app.setPath     ).to.be( undefined )
  #   expect( app.setParams   ).to.be( undefined )
  #   expect( app.locationFor ).to.be( undefined )

  #   locationPlugin.init()
  #   expect( app.locationFor ).to.be( locationPlugin.for )
  #   expect( app.setLocation ).to.be( locationPlugin.set )
  #   expect( app.setPath     ).to.be( locationPlugin.setPath )
  #   expect( app.setParams   ).to.be( locationPlugin.setParams )
  #   expect( app.locationFor ).to.be( locationPlugin.for )

  #   expect(app.set.calls).to.eql([])

  # it 'start and stop should add and remove evner listeners', ->
  #   expect(locationPlugin.window.addEventListener.calls).to.eql([])
  #   expect(locationPlugin.window.removeEventListener.calls).to.eql([])

  #   locationPlugin.init()
  #   expect(locationPlugin.window.addEventListener.calls).to.eql([])
  #   expect(locationPlugin.window.removeEventListener.calls).to.eql([])

  #   locationPlugin.start()
  #   expect(locationPlugin.window.addEventListener.calls).to.eql([['popstate', locationPlugin.update]])
  #   expect(locationPlugin.window.removeEventListener.calls).to.eql([])

  #   locationPlugin.stop()
  #   expect(locationPlugin.window.addEventListener.calls).to.eql([['popstate', locationPlugin.update]])
  #   expect(locationPlugin.window.removeEventListener.calls).to.eql([['popstate', locationPlugin.update]])


  # describe '#update', ->

  #   it 'should set "location"', ->

  #     expect(app.set.calls).to.eql([])

  #     locationPlugin.init()

  #     expect(app.set.calls).to.eql([])

  #     locationPlugin.update()

  #     expect(app.set.calls).to.eql([
  #       [ { location: {path: '/', params: {}}} ]
  #     ])
  #     locationPlugin.update()
  #     expect(app.set.calls).to.eql([
  #       [ { location: {path: '/', params: {}}} ],
  #       [ { location: {path: '/', params: {}}} ]
  #     ])

  #     locationPlugin.window.location = {
  #       pathname: '/login',
  #       search: '?username=Julia+Sanders&password=12345god',
  #     }

  #     locationPlugin.update()
  #     expect(app.set.calls).to.eql([
  #       [{ location: {path: '/', params: {}}}],
  #       [{ location: {path: '/', params: {}}}],
  #       [{ location: {path: '/login', params: {
  #         password: '12345god',
  #         username: 'Julia+Sanders'
  #       }}}]
  #     ])


  # describe '#for', ->
  #   it 'should generate location strings'
