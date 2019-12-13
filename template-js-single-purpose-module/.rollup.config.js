//
// Included to aid with the monolithic build of our library.
//
import pluginBabel from 'rollup-plugin-babel'
import pluginCommonjs from 'rollup-plugin-commonjs';
import pluginNodeResolve from '@rollup/plugin-node-resolve'
const packageJson = require('./package.json')

export default {
  output: {
    // Allows hyphenated module names.
    extend: true,
    // A name is needed for global export. Name comes from the package since
    // (1) it makes this config file portable, and
    // (2) makes the name of the package signifiant.
    name: packageJson.name,
  },
  plugins: [
    // Early experiments would throw errors with lodash, and this particular
    // order of plugins seems to work.
    pluginNodeResolve(),
    pluginBabel(),
    pluginCommonjs(),
  ]
}
