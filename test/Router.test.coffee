Router = require '../Router'

describe 'Router', ->

  HomePage  = {}
  UsersPage = {}
  UserPage  = {}
  NotFoundPage = {}

  it 'should work', ->

    router = new Router ->
      @match '/',               HomePage
      @match '/users',          UsersPage
      @match '/users/:user_id', UserPage
      @match '/*path',          NotFoundPage


    route = router.routeFor path: '/', params: {}
    expect( route.path    ).to.eql( '/'      )
    expect( route.params  ).to.eql( {}       )
    expect( route.page    ).to.be(  HomePage )


    route = router.routeFor path: '/users', params: {}
    expect( route.path    ).to.eql( '/users'  )
    expect( route.params  ).to.eql( {}        )
    expect( route.page    ).to.be(  UsersPage )

    route = router.routeFor path: '/users/12', params: {}
    expect( route.path    ).to.eql( '/users/12'  )
    expect( route.params  ).to.eql( {user_id:12} )
    expect( route.page    ).to.be(  UserPage     )


    route = router.routeFor path: '/asdfasdf', params: {}
    expect( route.path    ).to.eql( '/asdfasdf'  )
    expect( route.params  ).to.eql( {path:'asdfasdf'} )
    expect( route.page    ).to.be(  NotFoundPage     )
