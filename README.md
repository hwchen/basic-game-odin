Does not use the flake, as it doesn't seem to work great with nix/nixos (because of raylib).

Raylib gives an error that xlib cannot be found.

```
λbasic-game on  main [+2..] > odin run .                
INFO: Initializing raylib 5.0
INFO: Platform backend: DESKTOP (GLFW)
INFO: Supported raylib modules:
INFO:     > rcore:..... loaded (mandatory)
INFO:     > rlgl:...... loaded (mandatory)
INFO:     > rshapes:... loaded (optional)
INFO:     > rtextures:. loaded (optional)
INFO:     > rtext:..... loaded (optional)
INFO:     > rmodels:... loaded (optional)
INFO:     > raudio:.... loaded (optional)
WARNING: GLFW: Error: 65544 Description: X11: Failed to load Xlib
WARNING: GLFW: Failed to initialize GLFW
Segmentation fault (core dumped)
```

Some possibilities:
- https://discourse.nixos.org/t/what-is-sandboxing-and-what-does-it-entail/15533
- https://github.com/commercialhaskell/stack/issues/2735
