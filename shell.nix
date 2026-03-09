let inherit (import <nixpkgs> {}) mkShellNoCC cacert git curl remarshal go-jsonnet; in

mkShellNoCC { packages = [ cacert git curl remarshal go-jsonnet ]; }
