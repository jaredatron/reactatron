component = require './component'
{span} = require './DOM'


component 'Homepage',

  render: ->
    App.queryComponent
      query: [
        'params'
        'current_user'
      ],
      render: (results) =>
        {params, current_user} = results
        if !current_user
          div(null, "Loading..")
        else
          div(null, "Welcome back #{current_user.name}")


App.queryComponent = (props) ->
  props.app = this
  QueryStateMachine(props)

module.exports = component 'QueryStateMachine',

  propTypes:
    app:    React.PropTypes.ReactatronApp.isRequired
    query:  React.PropTypes.array.isRequired
    render: React.PropTypes.func.isRequired

  componentDidMount: ->
    @app.watch(@props.query, @rerender)

  componentWillUnmount: ->
    @app.unwatch(@props.query, @rerender)

  render: ->
    @props.render @app.query(@props.query)




App.get(['key1', 'key2'…]) # => [value1,value2…]
App.sub(keys, callback)
App.unsub(keys, callback)


