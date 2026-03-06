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
    mkHome = system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        modules = [
          ./home.nix
        ];
      };
  in
  {
    homeConfigurations."encodepanda@x86_64-darwin" = mkHome "x86_64-darwin";
    homeConfigurations."encodepanda@aarch64-darwin" = mkHome "aarch64-darwin";
  };
}
