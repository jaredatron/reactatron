require './helper'

Location = require '../Location'

describe 'Location', ->

  window = location = null

  beforeEach ->
    window = new FakeWindow
    window.location.pathname = '/posts'
    window.location.search   = '?order=asc'
    location = new Location(window:window)

    expect( window.addEventListener.callCount     ).to.be(0)
    expect( window.removeEventListener.callCount  ).to.be(0)
    expect( window.history.replaceState.callCount ).to.be(0)
    expect( window.history.pushState.callCount    ).to.be(0)


  describe '#constructor', ->

    it 'should bindAll', ->
      # instance = new Location window: {}
      # for property, value of instance
      #   if property


  describe '#update', ->

    it 'should set @path amd @params from window.location.pathname and window.location.search', ->
      expect( location.path   ).to.eql '/posts'
      expect( location.params ).to.eql order: 'asc'


  describe '#for', ->

    it 'should should return a location string for the given path and params defaulting to the current', ->
      expect( location.for()              ).to.eql '/posts?order=asc'
      expect( location.for('/foo')        ).to.eql '/foo?order=asc'
      expect( location.for('/foo', bar:2) ).to.eql '/foo?bar=2'
      expect( location.for(null, bar:2)   ).to.eql '/posts?bar=2'

  describe '#set', ->

    it 'should set the current location using window.history.replaceState or window.history.pushState', ->

      setStateMethodCall = null

      window.history.replaceState = (data, title, value) ->
        type = 'replaceState'
        setStateMethodCall = {data, title, value, type}

      window.history.pushState = (data, title, value) ->
        type = 'pushState'
        setStateMethodCall = {data, title, value, type}

      expect( location.set('/login?username=jared') ).to.be location
      expect( setStateMethodCall ).to.eql
        type:  "pushState"
        data:  {}
        title: "Reactatron Tests"
        value: "/login?username=jared"

      expect( location.set('/login?username=jared', true) ).to.be location
      expect( setStateMethodCall ).to.eql
        type:  "replaceState"
        data:  {}
        title: "Reactatron Tests"
        value: "/login?username=jared"



  describe 'instance', ->



    it 'should be amazing', ->
      expect(location).to.be.a(Location)
