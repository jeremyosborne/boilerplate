# JavaScript - Single purpose module

Inspiration and blatant stealing from: http://dev.topheman.com/package-a-module-for-npm-in-commonjs-es2015-umd-with-babel-and-rollup/

For non-React modules built to be shared with other projects and ~~not~~ rarely used on their own.

Assumptions:

* Babel 7.
* Babel CLI transpiles code.
* code may use bleeding edge ECMAScript things that babel can handle.
* source maps are provided...
    * ...however minification and other post processing is not, as these libraries are assumed to be shared objects consumed by other projects and build tools.
* source code lives in `src/`.
* the main entrypoint for your library is `src/index.js`.
* transpiled code is organized under `dist/`.
* test files should exist and use the extension with `.test.js` and be located next to the source code. (Test setup is located in a separate section).

Due to the state of modules in JavaScript to this day, we take the forgiving approach and provide as much as we can with our automated build tools:

* `CommonJS`: `require()` and `module.exports` based system. Assumed consumer is Node.js.
    * Dependencies are linked.
    * Code output -> `dist/commonjs`.
    * `package.json` via field `main`.
* `ES Modules`: `import` and `export` based system. Assumed consumer is another build tool, and modern environments that support modules natively.
    * Dependencies are linked.
    * Code output -> `dist/es`.
    * `package.json` via field `module`.
* `Monolithic: Immediately Invoked Function Expression`: This code should work anywhere, at the cost of being the least flexible and forcing export onto the `global` object of the runtime.
    * Dependencies are built into the module at build time; module will be bloated but self-contained.
    * Code output -> `dist/monolithic-iife`.
    * `package.json` via field `browser`.
* `Monolithic: UMD`: This code should work in most modern environments as well as those providing UMD friendly dependency management systems.
    * Dependencies are built into the module at build time; module will be bloated but self-contained.
    * Code output -> `dist/monolithic-umd`.
    * Not available through a `package.json` reference.
* `UMD`: The indecisive module system that is still a module system. Assumed consumer is not-Node.js.
    * Dependencies are linked.
        * NOTE: This build still assumes a module system is in place and isn't the commonly misunderstood usage of `umd to mean monolithic`.
    * Code output -> `dist/umd`.
    * Not available through a `package.json` reference.

## JavaScript Transpilation Setup

Install dev dependencies:

```bash
npm install --save-dev \
    `# babel specific` \
    @babel/cli `# prefer usage from the command line` \
    @babel/core `# needed for all things babel` \
    @babel/node `# for those times I need babel-node` \
    @babel/plugin-proposal-class-properties `# personal preference` \
    @babel/plugin-proposal-class-properties `# personal preference` \
    @babel/preset-env `# standard way to support es features` \
    @babel/preset-flow `# I have been using flow, will be switching to type-defs + JavaScript.` \
    babel-plugin-lodash `# make lodash import less heavy as we don't assume consumer has lodash` \
    `# monolithic build specific` \
    rollup `# combines into a monolithic build` \
    @rollup/plugin-node-resolve `# finds dependencies in the node_modules folder` \
    rollup-plugin-babel `# runs source code through babel` \
    rollup-plugin-commonjs `# handle incoming commonjs modules` \
    `# script helpers` \
    cross-env `# not everyone uses a Mac or linux like operating system` \
    del-cli `# powers our clean script` \
    `# end`
```

Merge the following to your `package.json`:

```json
{
    "browser": "dist/monolithic-iife/index.js",
    "main": "dist/commonjs/index.js",
    "module": "dist/es/index.js",
    "scripts": {
        "clean": "del dist/*",
        "build": "npm run clean && npm run build:commonjs && npm run build:es && npm run build:monolithic:iife && npm run build:monolithic:umd && npm run build:umd",
        "build:commonjs": "cross-env BABEL_ENV=commonjs babel src --out-dir dist/commonjs --ignore \"src/**/*.test.js\" --source-maps",
        "build:es": "cross-env BABEL_ENV=es babel src --out-dir dist/es --ignore \"src/**/*.test.js\" --source-maps",
        "build:monolithic:iife": "cross-env BABEL_ENV=es rollup src/index.js --format iife --config .rollup.config.js --sourcemap --file dist/monolithic-iife/index.js",
        "build:monolithic:umd": "cross-env BABEL_ENV=es rollup src/index.js --format umd --config .rollup.config.js --sourcemap --file dist/monolithic-umd/index.js",
        "build:umd": "cross-env BABEL_ENV=umd babel src --out-dir dist/umd --ignore \"src/**/*.test.js\" --source-maps",
        "prepare": "npm run build"
    }
}
```

Include [.babelrc](./.babelrc) for the config file used by babel in our scripts.

Include [.npmignore](./.npmignore) for a file that should work for packaging our files (since `npm` makes use `.gitignore` if this file does not exist).

include [.rollup.config.js](./.rollup.config.js) for assumed rollup config file used in `build:monolithic`.

## ESLinting

Install dev dependencies:

```bash
npm install --save-dev \
    eslint `# linter module and cli` \
    babel-eslint `# hook into babel` \
    eslint-config-standard `# based on js standard` \
    eslint-plugin-flowtype `# handle flow types` \
    eslint-plugin-import `# check for valid imports` \
    eslint-plugin-node `# nodejs recommendations` \
    eslint-plugin-promise `# promise styling` \
    eslint-plugin-standard `# plugin for standard style` \
    `# end`
```

Include [.eslintrc](./.eslintrc).

Merge the following to your `package.json`:

```json
{
    "scripts": {
        "lint": "eslint \"src/**/*.js?(x)\""
    }
}
```

## Flow

Install dev dependencies (flow stripper should be included in babel):

```bash
npm install --save-dev \
    flow-bin `# for all you typescript needs... just kidding ;)` \
    `# end`
```

Merge the following to your `package.json`:

```json
{
    "scripts": {
        "flow": "flow"
    }
}
```

## Testing (with Jest)

Install dev dependencies:

```bash
npm install --save-dev \
    jest `# test tool + cli executable` \
    babel-jest `# run code through babel` \
    `# end`
```

Merge the following to your `package.json`:

```json
{
    "scripts": {
        "test": "cross-env NODE_ENV=commonjs jest --config .jest.config.js"
    }
}
```

Include [.jest.config.js](./.jest.config.js). (Non-standard file name to hide config files from normal `ls` views).

## git hooks

Install dev dependencies:

```bash
npm install --save-dev \
    husky@next `# at the time of writing, future version still better.` \
    `# end`
```

Merge the following to your `package.json`. Note the following assumes you have done all of the above, including `flow`. Prune as necessary.

```json
{
    "husky": {
        "hooks": {
            "pre-push": "npm run lint && npm run flow && npm test"
        }
    }
}
```
