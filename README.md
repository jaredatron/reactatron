# Reactatron

- React but with the functions (AKA factory) way
- built for coffee script (maybe ES6?)
- has a flux-like event based system
- has a json-query data store with simple event hooks
- can json-query be used on mongo?
- provide a different api for making components
- provide a DOM object
- provide a global mixins feature
- provide subclassing components
- eveything is built as modules with the borders well documented
- module: js css framework (need benchmarking)
- we provide the start and stop level boilerplate code
- maybe we prevent components from being defined dynanically because we know start/stop state


## Arcitecture


#### component



#### App

- starts and stops the global listeners like popstate
- initializes the state of the app
- do we need some sort of "plugin" system here?


#### State


- state is just a big plan object
- IT IS NOT state a string key, value store !!!!!



- this is given to the page component
  - which should pull the data it needs and also register a handler
- all of its top level values are available
- um... stores state?
- lets you know when state changes
- lets you ask for the values of keys and get the current valye and updates, via callback and imediate return

```coffee

keys = [
  'current_user.first_name',
  'current_user.last_name',
]

state.get keys, (values) ->
  {first_name, last_name} = values
  # or better yet
  @setState(values)


component 'FilesPage',

  getInitialState: ->
    data = App.tellMeWhenChange(

    )
    @setState(data)

  render: ->
    {first_name, last_name} = App.state.current_user
    h1(null, "Welcome back #{first_name} #{last_name}")




```

### The Cycle

##### First render


```coffee

render: ->

  DataQuery
    keys:
      'current_user.first_name'
      'current_user.last_name'
    loading: ->

    loaded: (values) ->

    error: (error) ->



DataQuery = component
  propTypes:
    keys: queryKeySet



  render: ->


```



#### React Tree



#### Actions



```js
ReactatronApp = require('reactatron/App')
App = new ReactatronApp

App.router.map ->
  @match '/', @redirectTo '/transfers'

App.start()
App.stop()

@context.path
@context.params
@context.setPath(path)
@context.setParams(params)
@context.setLocation(path, params)

App.on 'location:change',  @onLocationChange
App.off 'location:change', @onLocationChange
App.routes ->
  @match

Button = require('components/Button')
App.component 'MagicButton',
  render: ->
    Button()
```

There needs to be an internal way, other than the app the user create, to set the location
or not create apps?








#### Components

- Text

No text is selectable unless wrapped in one of these text components

- ColumnsContainer
- RowsContainer
- Button
- Link
