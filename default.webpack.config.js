var path = require('path');
// var ExtractTextPlugin = require('extract-text-webpack-plugin');

// var constants = new webpack.DefinePlugin({
// //   PUTIO_APPLICATION_SECRET: JSON.stringify(ENV.PUTIO_APPLICATION_SECRET),
// //   PUTIO_CLIENT_ID:          JSON.stringify(ENV.PUTIO_CLIENT_ID),
// //   PUTIO_OAUTH_TOKEN:        JSON.stringify(ENV.PUTIO_OAUTH_TOKEN),
// //   PUTIO_REDIRECT_URI:       JSON.stringify(ENV.PUTIO_REDIRECT_URI),
// })

// const APP_ROOT = __dirname
// const srcDir = __dirname+'/src'
// const publicPath = __dirname+'/public'

module.exports = (Reactatron) => {
  var ExtractTextPlugin = Reactatron.ExtractTextPlugin
  return {
    entry: {
      "client.js": Reactatron.clientSrcPath,
      "style.css": Reactatron.styleSrcPath
    },
    output: {
      publicPath: '/',
      path: Reactatron.publicPath,
      filename: "[name]",
      chunkFilename: "[id].chunk.js"
    },
    plugins: [
      // constants,
      new ExtractTextPlugin("style.css")
    ],
    resolve: {
      modulesDirectories: [Reactatron.root+'/node_modules'],
    },
    module: {
      loaders: [
        {
        test: /\.sass$/,
          loader: ExtractTextPlugin.extract("style", "css!sass")
        },
        {
          test: /\.json$/,
          loader: 'json-loader'
        },
        {
          test: /.js$/,
          loader: 'babel-loader',
          include: Reactatron.srcDir,
          exclude: path.resolve(__dirname, 'node_modules'),
          query: {
            presets: ['es2015', 'react', 'stage-0']
          }
        }
      ]
    }
  }
}
