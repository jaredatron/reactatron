component = require './component'

{div} = require './DOM'

module.exports = component 'RootComponent',

  propTypes:
    app: component.PropTypes.object.isRequired

  childContextTypes:
    app: component.PropTypes.object

  getChildContext: ->
    app: @props.app

  componentDidMount: ->
    @props.app.sub 'store:change:location', @rerender
  componentWillUnmount: ->
    @props.app.unsub 'store:change:location', @rerender

  render: ->
    app = @props.app
    location = app.get('location')
    route = app.router.pageFor(location.path, location.params)
    {path, params} = route
    page = route.getPage()
    page
      path: path
      params: params
