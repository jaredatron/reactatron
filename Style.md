# Style

we have to do as much define-time style calculation as possible
simply because responsive style definitions are never going to
be terse enough :(




WE ARE: getting rid of `withStyle` and instead going
with a comprehensive mixins system?


??? maybe our magic styling is all just one component with a
complex pros system `Box` ???

## Mixin / Expansion system

- we figure out what vendor prefixes we need and only
render the ones we need
- we do whatever css property override thing React does
(i think this emultes cascading to some degree)


there is already presidence for css properties that
override other css properties. For example:

```css
body{
  border: 1px solid black;
  border-left-width: 4px;
}
```

So our mixin approach mirrors that with expansions like:

```css
body{
  border-radius: 5px;
}
```

expands to:

```css
body{
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -mox-border-radius: 5px;
  -o-border-radius: 5px;
}
```



There are two ways to re-ue styles:

A) at definition time

```coffee
RedBox = div.withStyle
  backgroundColor: 'red'
```

B) at render time


```coffee
RedBox = component (props) ->
  props.extendStyle
    backgroundColor: 'red'
  div(pros)
```












## Layout Examples



```coffee
Layer
  Rows
    Header height: '100px'
    Columns
      Sidebar width: '200px'
      MainContent
```





## Flexbox tricks

You can fix the width of a flex column by setting both `minWidth` and `flexBasis`

```sass
minWidth:  20px
flexBasis: 20px
```


## StyledComponent

- just styles and a component





we need a stlye inheritance thing along side composure so were
not using 10x more react components







i think we only need inline-flex and inline-block
wrapping should never be a default


whats a good name for the difference between your children fitting or overflowing/scrolling?



Box

Block

Rows & Columns

Scrollbox ?









button = React.DOM.button


# merging styles inline
BlueButton = component (props) ->
  props.style.update BlueButton.style
  button(props)

# merging styles at definition time

BlueButton = Button.style
  backgroundColor: 'blue'


# do we need to wrap each core component with a styled component wrapper?
