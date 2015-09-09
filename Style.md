# Style




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
