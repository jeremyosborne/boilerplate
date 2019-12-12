# JavaScript - Single purpose module

Inspiration and blatant stealing from: http://dev.topheman.com/package-a-module-for-npm-in-commonjs-es2015-umd-with-babel-and-rollup/

For modules built to be shared with other projects and not used on their own. No JSX, just JavaScript.

Assumptions:

* Babel 7 is used.
* Babel CLI transpiles code and provides source maps to aid consumers of code.
* consumers of the code will add any decoration or post processing (e.g. minification) as needed, even for umd builds.
* happy using bleeding edge ECMAScript things that babel can handle.
* source code will always live in `src/`.
* transpiled code is organized under `dist/` and should be `.gitignore`d.
* test files should exist and use the extension with `.test.js` and be located next to the source code. (Test setup is located in a separate section).

## JavaScript Transpilation Setup

Install dev dependencies:

```bash
npm install --save-dev \
    `# babel specific` \
    @babel/cli `# prefer usage from the command line` \
    @babel/core `# needed for all things babel` \
    @babel/plugin-proposal-class-properties `# personal preference` \
    @babel/plugin-proposal-class-properties `# personal preference` \
    @babel/preset-env `# standard way to support es features` \
    @babel/preset-flow `# I like the opt in flavor of flow over typescript` \
    babel-plugin-lodash `# make lodash import less heavy as we don't assume consumer has lodash` \
    `# script helpers` \
    cross-env `# not everyone uses a Mac or linux like operating system` \
    del-cli `# powers our clean script` \
    `# end`
```

Merge the following to your `package.json`:

```bash
{
    "browser": "dist/umd/index.js",
    "main": "dist/commonjs/index.js",
    "module": "dist/es/index.js",
    "scripts": {
        "clean": "del dist/*",
        "build": "npm run clean && npm run build:commonjs && npm run build:es && npm run build:umd",
        "build:commonjs": "cross-env BABEL_ENV=commonjs babel src --out-dir dist/commonjs --ignore \"src/**/*.test.js\" --source-maps",
        "build:es": "cross-env BABEL_ENV=es babel src --out-dir dist/es --ignore \"src/**/*.test.js\" --source-maps",
        "build:umd": "cross-env BABEL_ENV=umd babel src --out-dir dist/umd --ignore \"src/**/*.test.js\" --source-maps",
        "prepare": "npm run build"
    }
}
```

See [.babelrc](./.babelrc) for config file that powers our scripts.

See [.npmignore](./.npmignore) for a file that should work for packaging our files (since `npm` makes use `.gitignore` if this file does not exist).
