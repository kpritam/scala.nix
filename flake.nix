{
  description = "Dev shell for Scala and Node";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            zulu11
            scala_2_13
            sbt
            nodejs_20
          ];

          shellHook = ''
            echo "Welcome to Nix Shell"
            export PATH="${pkgs.zulu11}/bin:$PATH"
            alias sbt "sbt -java-home ${pkgs.zulu11}"
          '';
        };
      }
    );
}

