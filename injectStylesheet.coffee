module.exports = (document, styles) ->
  style = document.createElement('style');
  style.type = 'text/css'
  style.innerHTML = styles || 'body {}'
  document.getElementsByTagName('head')[0].appendChild(style);
  document.styleSheets[document.styleSheets.length-1];
