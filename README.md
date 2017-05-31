# scripts

Various scripts, configs, partials, and random code that I find useful in my projects.

## Boilerplate

### Atom

```bash
apm install \
    atom-beautify \
    atom-handlebars \
    docblockr \
    editorconfig \
    file-icons \
    git-diff-details \
    language-babel \
    linter \
    linter-eslint \
    linter-stylelint \
    markdown-pdf \
    merge-conflicts \
    open-in-browser \
    script \
    tree-view-git-status \
    `# all done`
```

### CSS Modules (in react with scss)

```bash
npm install --save-dev \
    autoprefixer \
    babel-plugin-react-css-modules \
    postcss \
    postcss-loader \
    postcss \
    `# all done`
```

Modifications to `.babelrc`:

```js
{
  "presets": ["react", "es2015", "stage-0"],
  "plugins": [
    ["react-css-modules", {
      "generateScopedName": "[name]__[local]___[hash:base64:5]",
      "filetypes": {
        ".scss": "postcss-scss"
      }
    }],
  ],
  "env": {
    "development": {
      "plugins": [
        ["react-css-modules", {
          "webpackHotModuleReloading": true,
        }],
      ],
    },
  }
}
```

Modifications to `webpack.config.js`:

```js
{
  modules: {
    rules: [
      {
        test: /\.s?css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              query: {
                minimize: IS_PRODUCTION,  // assuming you have IS_PRODUCTION defined...
                modules: true,
                localIdentName: '[name]__[local]___[hash:base64:5]',
              },
            },
            {
              loader: 'sass-loader',
            },
            'postcss-loader',
          ]
        })
      },
    ]
  }
}
```

Make use of [.postcssrc.js](./postcssrc.js).

### ESlint

[JavaScript Standard Style](http://standardjs.com/) as a basis with personal preferences and the ease of use with eslint itself:

```bash
npm install --save-dev \
    babel-eslint \
    eslint \
    eslint-config-standard \
    eslint-config-standard-react \
    eslint-plugin-import \
    eslint-plugin-node \
    eslint-plugin-promise \
    eslint-plugin-react \
    eslint-plugin-standard \
    eslint-import-resolver-webpack \
    `# all done`
```

Atom support:

```bash
apm install \
    language-babel \
    linter \
    linter-eslint \
    `# all done`
```

Usage (recommend embedding in a package.json script). Note: Quotes are
necessary to trigger string being treated as glob expression:

```
eslint "src/**/*.js?(x)"
```

Recommend keeping `.eslintrc` file named as is as it seems certain tools still only look for that name.
