component = require './component'

URI = require 'uri-js'

module.exports = component 'RootComponent',

  propTypes:
    path:         component.PropTypes.string.isRequired
    params:       component.PropTypes.object.isRequired
    page:         component.PropTypes.func.isRequired

    locationFor:  component.PropTypes.func.isRequired
    setLocation:  component.PropTypes.func.isRequired
    setPath:      component.PropTypes.func.isRequired
    setParams:    component.PropTypes.func.isRequired
    updateParams: component.PropTypes.func.isRequired

  childContextTypes:
    path:         component.PropTypes.string
    params:       component.PropTypes.object
    setLocation:  component.PropTypes.func
    locationFor:  component.PropTypes.func
    setPath:      component.PropTypes.func
    setParams:    component.PropTypes.func
    updateParams: component.PropTypes.func

  getChildContext: ->
    path:         @props.path
    params:       @props.params
    setLocation:  @props.setLocation
    locationFor:  @props.locationFor
    setPath:      @props.setPath
    setParams:    @props.setParams
    updateParams: @props.updateParams

  componentDidMount: ->
    # intercept all link clicks
    # force relative links to use pushState
    document.addEventListener('click', @onClick)

  componentWillUnmount: ->
    document.removeEventListener('click', @onClick)

  onClick: (event) ->
    return unless event
    return unless target = event.target
    return unless target.nodeName == 'A'
    uri = parseURI(target.href)
    return if uri.origin != location.origin
    event.preventDefault()
    console.log('PUSHSTATE', target.href, uri)
    @props.setLocation(uri.asRelative)

  render: ->
    @props.page()


parseURI = (href) ->
  uri = URI.parse(href)
  uri.origin = uri.scheme+'://'+uri.host
  uri.asRelative = href.replace(uri.origin,'')
  uri



