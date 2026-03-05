{
  description = "EncodePanda's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-darwin"; # change to aarch64-darwin if Apple Silicon
    pkgs = import nixpkgs { inherit system; };
  in
  {
    homeConfigurations.encodepanda =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
      };
  };
}
