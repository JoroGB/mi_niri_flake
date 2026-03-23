#!/usr/bin/env nu

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
