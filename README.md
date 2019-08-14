# scripts and boilerplate

Various scripts, configs, partials, and random code that I find useful in my projects.

- [Atom](#atom)
- [CSS Modules (in react with scss)](#css-modules-in-react-with-scss)
- [ESlint](#eslint)
- [Mac](#mac)
  * [brew](#brew)
  * [.bash_profile additions](#bash_profile-additions)
- [Markdown](#markdown)
  * [Table of Contents generation](#table-of-contents-generation)

## Atom

```bash
apm install \
    atom-beautify `# Auto-prettification for a lot of formats.` \
    atom-handlebars `# Support for handlebars templating.` \
    docblockr `# Semi-intelligent comment auto-propagation.` \
    editorconfig `# Atom integration of .editorconfig.` \
    file-icons `# Detect and identify file types by icon in the tree view.` \
    language-babel `# Auto formatting and interpration of ES* feature (and JSX).` \
    linter `# Generic linter engine with support for multiple languages (install language packs separately).` \
    linter-eslint `# Support eslint for JavaScript.` \
    linter-stylelint `# Support stylelint for (S)CSS.` \
    open-in-browser `# Shortcut key support to launch a page in the browser.` \
    platformio-ide-terminal `# Integrated terminal that pulls in environment.` \
    script `# Run open file as script, or a portion of the file.` \
    tree-view-git-status `# Info in tree view (haven't testing if this is still necessary with recent git integration).` \
    `# All done.`
```

## CSS Modules (in react with scss)

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

## ESlint

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

Recommend keeping `.eslintrc` file named as is as it seems certain tools still only look for that name (not sure this is relevant anymore, probably can remove this rule).

## Mac

### brew

* Install command line tools with `xcode-select --install`.
* [Install homebrew](https://brew.sh/).
* [Setup terminal style](./jeremy.terminal).
* [Copy over .vimrc](./vimrc).

```bash
brew doctor

brew install \
    bash-completion `# tab completion++` \
    dos2unix `# Convert line endings in a text file.` \
    git `# Let brew manage git.` \
    heroku `# Heroku client.` \
    node `# Node.js.` \
    nvm `# Manage version of node on system.` \
    pipenv `# Pip + virtualenv combined.` \
    pandoc `# Convert documents from one filetype to another.` \
    python \
    python3 \
    ruby \
    `# All done.`
```

### .bash_profile additions

```bash
# colorized ls
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Recursively remove annoying things.
alias rmNUKE="find . -name '*.DS_Store' -type f -delete; find . -name 'node_modules' -type d -exec rm -rf {} +; find . -name '*.pyc' -type f -delete; find . -name '*.class' -type f -delete"

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
# git completion, requires completion to be loaded from above
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
# no get git colors
# export PS1='[\u@mbp \w$(__git_ps1)]\$ '
# get git colors
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\$ "'
```

## Markdown

### Table of Contents generation

```bash
npm install -g markdown-toc

# then... (the echo is for better copy-paste)
markdown-toc README.md --no-firsth1 && echo ""

# copy paste back into markdown file
```
