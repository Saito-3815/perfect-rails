// importやrequireを使わずにjQueryを使えるようにする
const webpack = require('webpack');
module.exports = new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
});