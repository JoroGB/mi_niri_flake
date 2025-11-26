
{
  description = "Niri Stable + Noctaclia + Home Manager + Rust-Fenix + Personal Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
       url = "github:noctalia-dev/noctalia-shell";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs = {
          # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
          # to have it up-to-date or simply don't specify the nixpkgs input
          nixpkgs.follows = "nixpkgs";
          home-manager.follows = "home-manager";
        };
      };
  };
#                                                             Para poder usar inputs dentro de SpecialArgs
  outputs = { self, nixpkgs, home-manager, niri-flake, fenix, ... }@inputs:
  let
    #overlays
    overlays_flake = [
      niri-flake.overlays.niri
      fenix.overlays.default
    ];
    # home manager settings
    mi_home_manager = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };  # ← Esto pasa inputs a home.nix
      home-manager.users.joronix = import ./home.nix;
    };

  in {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {nixpkgs.config.allowUnfree = true;}
          {nixpkgs.overlays = overlays_flake;}
          home-manager.nixosModules.home-manager
          mi_home_manager
          ./config/configuration.nix
          ./config/hardware-configuration.nix
        ];
    };
  };
}
