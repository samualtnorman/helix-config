# Samual's Helix Config
This is my personal [Helix](https://helix-editor.com/) config. If you want to use it yourself, you'll need to build the
`config.toml` and `languages.toml` files.

## Setup
Make sure you have this repository cloned to `~/.config/helix`.

If you have [direnv](https://direnv.net/), run `direnv allow`. Otherwise, if you have [Nix](https://nixos.org/download/)
run `nix-shell`. Otherwise you will need to install [curl](https://curl.se/), [Remarshal](https://pypi.org/project/remarshal/),
[jq](https://jqlang.org/), and [Jsonnet](https://jsonnet.org/) (specifically
[go-jsonnet](https://github.com/google/go-jsonnet)).

## Build
Run `scripts/fetch-deps.sh`, then run `./helix.jsonnet`. If you have Helix already open, either close and open it or run
`:config-reload` to apply the new config.

## Credit
These files:
- `themes/base16_terminal.toml`
- `themes/catppuccin_mocha.toml`
- `runtime/queries/ecma/highlights.scm`
- `runtime/queries/_typescript/highlights.scm`

Are forked from the [Helix repository](https://github.com/helix-editor/helix).
