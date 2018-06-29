# Hammerspoon

This repo contains my Hammerspoon configuration.

Note: One file containing private data is not included in the repo. It is called `privateLH.lua`. In order to run this code, references to the constants defined in this module must be removed.

Major functionality:

* window management (app specific default positions)
* application menus
* text replacement using chooser

## Tips and tricks

Slow key repeat rate

* I am using the fix from [stackoverflow](https://stackoverflow.com/questions/40986242/key-repeats-are-delayed-in-my-hammerspoon-script)
* Implemented in `hsLH.fastKeyBind`.

------------------