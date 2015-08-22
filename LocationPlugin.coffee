class LocationPlugin

  location: global.location
  window: global.window

  constructor: (options={}) ->
    Object.assign(this, options)

  start: ->
    window.addEventListener 'popstate', @update

  stop: ->
    window.removeEventListener 'popstate', @update

  update: ->
    console.log('LocationPlugin update')

module.exports = LocationPlugin
