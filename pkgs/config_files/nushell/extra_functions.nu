#! /usr/bin/env nu

# ruta de configuracion de nvim
export const cpath_nvim = ('~/.config/nvim' | path expand)
# ruta de respaldo de nvim
export const bpath_vim = ('~/mi_niri_flake/pkgs/config_files/nvim' | path expand)


# funcion para reconstruir el sistema con flakes y el perfil de pc
export def u_nixos_pc [] {
    sudo nixos-rebuild switch  --flake ~/mi_niri_flake/.#pc
  }

export def exportconf_nvim [] {
  print $"Exportando configuracion de ($bpath_vim)"
  rsync -avh $bpath_vim $cpath_nvim
  print $"Copiado en ($cpath_nvim)"
}


# Esta funcion guarada los arhicvos modificados en ~/.config/nvim/
export def sf_nvim [] {
  print $"Haciendo copia de ($cpath_nvim)"
  rsync -avh $cpath_nvim $bpath_vim
  print $"Copiado en ($bpath_vim)"
}


# Elimina archivos Temporales de lazyvim
export def dtf_nvim [] {
  # Limpia archivos temporales de Neovim

  print "Limpiando archivos temporales de Neovim..."

  # Eliminar swap files
  print "Eliminando swap files..."
  rm -rf ~/.local/state/nvim/swap/*
  rm -rf ~/.local/share/nvim/swap/*

  # Eliminar shada files
  print "Eliminando shada files..."
  rm -rf ~/.local/state/nvim/shada/*
  rm -rf ~/.local/share/nvim/shada/*

  # Eliminar backups
  rm -rf ~/.local/share/nvim/backup/*

}



