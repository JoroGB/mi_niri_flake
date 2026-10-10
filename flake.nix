{
  description = "Niri Stable + Noctaclia + Home Manager + Rust-Fenix + Personal Config";

  inputs = {
    # pc_control = {
    #   url = "path:/home/joronix/Proyects/pc_control";
    # };
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qylock.url = "github:Darkkal44/qylock";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #  url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
        #
        # to have it up-to-date or simply don't specify the nixpkgs input
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  #                                                             Para poder usar inputs dentro de SpecialArgs
  outputs = {
    self,
    nixpkgs,
    home-manager,
    niri-flake,
    fenix,
    agenix,
    qylock,
    # hyprland,
    ...
  } @ inputs: let
    #overlays
    overlays_flake = [
      niri-flake.overlays.niri
      fenix.overlays.default
      (final: prev: {
        pihole-ftl = prev.pihole-ftl.overrideAttrs (old: {
          env =
            (old.env or {})
            // {
              NIX_CFLAGS_COMPILE =
                (old.env.NIX_CFLAGS_COMPILE or "") + " -Wno-error=unused-but-set-variable";
            };
        });
      })
    ];
    # callpackages
    # home manager settings
    mi_home_manager = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs;}; # ← Esto pasa inputs a home.nix
      home-manager.users.joronix = import ./home.nix;
    };
  in {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        {
          nixpkgs.config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        }
        {nixpkgs.overlays = overlays_flake;}
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        mi_home_manager
        ./config/configuration.nix
        ./config/modules/sddm-themes.nix
      ];
    };
  };
}
