{ config, pkgs, inputs, ... }:
{
  imports =[
    inputs.zen-browser.homeModules.twilight

    inputs.niri-flake.homeModules.niri
    ./desktop/niri/niri_custom.nix

    inputs.noctalia.homeModules.default
    ./desktop/niri/noctalia.nix

    ./programs/fenix.nix
    # ./programs/neovim.nix

    ./desktop/hyprland/hyprland_custom.nix
  ];
  programs.zen-browser.enable = true;


  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    grimblast
    grim
    slurp
    libnotify

    # Caracteres Japoneses, kanjins etec..
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];



}
