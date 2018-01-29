# MGPL-Xtext

This project contains the grammar, validators and code generator for the Mini-Game-Programming-Language(MGPL).
It uses the xtext-framework to provide these features and allows you to spawn an eclipse instance, in which you can
program your game with MGPL.

## The MGPL editor
"On-Save", your code gets checked and if its correct, compiled to valid TypeScript code.
To play your game, simply open the created `index.html` in the `src-gen` directory in your browser.
The TypeScript code gets compiled in the browser to JS, so there's no extra step for you to do.
*Please make sure to have a working internet connection it the game downloads the typescript compiler over the network*
