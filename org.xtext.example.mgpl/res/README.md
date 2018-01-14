# Pong mini framework

This mini framework written in Typescript is designed for simple pong browser games.

## Get it up and running
First, make you sure you have [typescript installed](https://www.typescriptlang.org/index.html#download-links).

Then, in this directory, run `tsc -m "ES2015" --outDir dist/ src/pong.ts`
As you can see, the JS modules get compiled as `ES2015` modules. Currently, **only the latest Chrome & Firefox** can load these modules natively.
When the compiler is done, put the `dist/index.html` on a webserver and load it with one of these browsers.

## Development
You can let typescript watch your code and recompile it when it changes.
To do so, you can use this command:
```
tsc --watch -m "ES2015" --outDir dist/ src/pong.ts
```

## TODO
In `src/pong.ts`, you see a naive transfer implementation of the `pong.mgpl` code to typescript.
The goal is to have an optimal framework for this specific usecase, so the code generation with xtend is as straightforward
as possible while having clean code.