let inherit (import <nixpkgs> {}) mkShellNoCC cacert git curl remarshal jq go-jsonnet; in

mkShellNoCC { packages = [ cacert git curl remarshal jq go-jsonnet ]; }
