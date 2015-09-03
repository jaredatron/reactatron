require './helper'

SimpleRouter = require '../SimpleRouter'

describe 'SimpleRouter', ->


  it 'should work', ->

    setLocation = new CallLogger
    renderPage  = new CallLogger

    router = new SimpleRouter ->
      switch
        # when @match '/'
        when @path == '/'             then setLocation '/home'
        when @path == '/home'         then renderPage 'home'
        when @match '/about'          then renderPage 'about'
        when @match '/users/:userId'  then renderPage 'users', @pathParams
        else                               renderPage 'NotFound'

    expect(router).to.be.a(SimpleRouter)

    setLocation.reset()
    renderPage.reset()
    router.route path: '/', params: {}
    expect( setLocation.calls ).to.eql [['/home']]
    expect( renderPage.calls  ).to.eql []

    setLocation.reset()
    renderPage.reset()
    router.route path: '/home', params: {}
    expect( setLocation.calls ).to.eql []
    expect( renderPage.calls  ).to.eql [['home']]

    setLocation.reset()
    renderPage.reset()
    router.route path: '/about', params: {}
    expect( setLocation.calls ).to.eql []
    expect( renderPage.calls  ).to.eql [['about']]

    setLocation.reset()
    renderPage.reset()
    router.route path: '/users/12', params: {}
    expect( setLocation.calls ).to.eql []
    expect( renderPage.calls  ).to.eql [['users',{userId:'12'}]]
