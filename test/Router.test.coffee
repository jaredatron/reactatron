require './helper'

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
    expect( route ).to.eql id: 0, path: '/', params: {}
    expect( router.pageForRoute(route) ).to.be HomePage


    route = router.routeFor path: '/users', params: {}
    expect( route ).to.eql id: 1, path: '/users', params: {}
    expect( router.pageForRoute(route) ).to.be UsersPage

    route = router.routeFor path: '/users/12', params: {}
    expect( route ).to.eql id: 2, path: '/users/12', params: {user_id:12}
    expect( router.pageForRoute(route) ).to.be UserPage


    route = router.routeFor path: '/asdfasdf', params: {}
    expect( route ).to.eql id: 3, path: '/asdfasdf', params: {path:'asdfasdf'}
    expect( router.pageForRoute(route) ).to.be NotFoundPage
