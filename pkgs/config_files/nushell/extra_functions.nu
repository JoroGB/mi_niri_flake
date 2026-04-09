#! /usr/bin/env nu

# ruta de configuracion de nvim
export const cpath_nvim = ('~/.config' | path expand)
# ruta de respaldo de nvim
export const bpath_vim = ('~/mi_niri_flake/pkgs/config_files' | path expand)


# funcion para reconstruir el sistema con flakes y el perfil de pc
export def u_nixos_pc [] {
    sudo nixos-rebuild switch  --flake ~/mi_niri_flake/.#pc
  }
# Exporta la configuracion  a .config/nvim/ 3
export def exportconf_nvim [] {
  print $"Exportando configuracion de ($bpath_vim)"
  rsync -avh $"($bpath_vim)/"  $cpath_nvim #--delete
  print $"Copiado en ($cpath_nvim)"
}


# Esta funcion guarada los arhicvos modificados en ~/.config/nvim/ al repositorio mi_niri_flake
export def sf_nvim [] {
  print $"Haciendo copia de ($cpath_nvim)"
  rsync -avh $"($cpath_nvim)/nvim" $"($bpath_vim)" #--delete
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
export def get_id_w [value?: string] {
    let inp = $in
    let v = if ($value != null) { $value } else { $inp }
    $v | grep -oE '[0-9]+$' | str trim
}


export def set_wallpaper [ 
  number?: int
  --adding:string (-a)
  --random (-r)
  --display (-d) = "DP-1"
  --name:string (-n)
  --last (-l)
  --debug
  --clear (-c)
] {

  job list | each {|job| job kill $job.id}
  let path_file =  ('~/mi_niri_flake/desktop/wallpaper/wallpaper_engine_links.csv' | path expand)
  if $adding != null {
    $"\nnull,null,($adding)"| save --append $path_file
  }

  if $clear {
      match (ps | where name =~ "linux-wallpaper" | length) {
          0 => { print "nothing to do" }
          _ => {
              let memory = (ps | where name =~ "linux-wallpaper" | get mem | math sum )
              print $"liberando ($memory)"
              ps | where name == "linux-wallpaper" | each { |w| kill $w.pid }
              print "limpieza completa"
        }
      }
  }

  if $random {
    # numero aleatorio con respecto a wallpaper_engine_links
    let total_lines = (open $path_file |select id | length )
    print $"debug lines length: ($total_lines)"
    let r_number = random int 1..($total_lines - 1)
    print $"debug random number: ($r_number)"
    let id = (open $path_file |select id | get id | get ($r_number - 1) | get_id_w |into int)
    print $"workshop id: ($id)"
    # linux-wallpaperengine --screen-root $display $id
    job spawn {linux-wallpaperengine --screen-root $display $id}


  } 
  if $name != null {
    let id: int = (open $path_file | where name == $name  | get id | get 0 | get_id_w | into int) 
    job spawn {linux-wallpaperengine --screen-root $display $id}
  }

  if $last {
    job spawn {
        let id_l = (open $path_file | last | get id | get_id_w | into int)
        print $id_l
        linux-wallpaperengine --screen-root $display $id_l
    }
  }
}
