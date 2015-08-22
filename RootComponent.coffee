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
    {path, params, page} = @props.app.router()
    page
      path: path
      params: params
