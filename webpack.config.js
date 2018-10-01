const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  context: __dirname,
  entry: "./src/index.js",
  output: {
    path: __dirname,
    filename: "index.js"
  },
  resolve: {
    modules: ["node_modules", "output"],
    extensions: [".js"]
  },
  module: {},

  plugins: [
    new HtmlWebpackPlugin({
      template: "src/index.html",
      filename: "index.html",
      minify: {
        collapseWhitespace: true
      }
    })
  ],

  devServer: {
    historyApiFallback: true
  }
};
