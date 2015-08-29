# Style


StyledComponent
 - just styles and a component





we need a stlye inheritance thing along side composure so were
not using 10x more react components








what if we only inject the style wrapping component around
"native" or "root" components by wrapping those in the DOM
object?



i think we only need inline-flex and inline-block
wrapping should never be a default


whats a gooe name for the difference between your children fitting or overflowing/scrolling?



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
