{
  description = "Zola Static Developer Environment";

  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { 
            inherit system;
            config.allowUnfree = true;
        };
        naersk-lib = pkgs.callPackage naersk { };
      in
      {
        defaultPackage = naersk-lib.buildPackage ./.;
        devShell = with pkgs; mkShell {
          nativeBuildInputs = [ pkg-config ];
          buildInputs = [ 
            zola
            cargo 
            rustc 
            rust-analyzer
            rustfmt
            pre-commit
            openssl
            rustPackages.clippy
            html5validator
            ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          shellHook = ''
          '';
        };
      }
    );
}
