#!/usr/bin/env nu

let nvim_path = ('~/.config/nvim' | path expand)
let destiny_path = ('~/mi_niri_flake/pkgs/config_files/' | path expand)

print $"Haciendo copia de ($nvim_path)"
rsync -avh $nvim_path $destiny_path
print $"Copiado en ($destiny_path)"
