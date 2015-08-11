module.exports = {
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },
  resolve: {
    extensions: ["", ".coffee", ".js"]
  }
};

