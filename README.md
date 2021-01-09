# EncodePanda's home-manager configuration

> Nix all the things!

## Installation

### Install Nix

```
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```

### Install home-manager

Follow simple instruction at [https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)

### Clone this repo and link to .config/nixpkgs/

```
cd ~/projects/
git clone https://github.com/EncodePanda/h.git

cd ~/.config

ln -s ~/projects/h nixpkgs
```
