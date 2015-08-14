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



```js
App = Reactatron.createApp()
App.start()
App.stop()
App.path
App.params
App.setPath(path)
App.setParams(params)
App.setLocation(path, params)
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
