{
  description = "A Nix-flake for fmc";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  outputs = { self, nixpkgs }:
    let
      javaVersion = 21; # Change this value to update the whole stack

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
          buildInputs = with pkgs; [ maven gradle openjdk21 nodejs ];
          shellHook = ''
              export JAVA_HOME=${pkgs.openjdk21}
              PATH="${pkgs.jdk21}/bin:$PATH"
          '';
      };
    };
}
