#! /usr/bin/env nu

# ruta de configuracion de nvim
export const cpath_nvim = ('~/.config' | path expand)
# ruta de respaldo de nvim
export const bpath_vim = ('~/mi_niri_flake/pkgs/config_files' | path expand)


# funcion para reconstruir el sistema con flakes y el perfil de pc
export def u_nixos_pc [] {
    sudo nixos-rebuild switch  --flake ~/mi_niri_flake/.#pc --impure
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
# esta funcion devuelve los el ultimo numero de una cadena de caracteres
# Ejemplo get_id_w "abc123" = 123
export def get_id_w [value?: string] {
    let inp = $in
    let v = if ($value != null) { $value } else { $inp }
    $v | grep -oE '[0-9]+$' | str trim | into int
}

# esta funcion ayuda a gestionar wallpapers de steam con linux-wallpaperengine
# solo guarda y gestiona los nombres y codigos de la workshop de steam para 
# tener un acceso mas sencillo, no guardar ni recopila nada mas que los nombre
# y codigo de la workshop, todo lo demas lo gestiona wallpaper-engine y 
# linux-wallpaperengine
#
# Argumentos
# adding: añade un wallpaper a una lista tipo csv
# random: los wallpapers agregados en la lista establece uno aleatorio,
#   se puede selecionar el nombre del monitor con $display
# display: es el nombre del monitor al que se le establecera el wallpaper
# name: establece el wallpaper por el nombre que se guardo en lista
# byname: al usar --adding o --remove se puede usar este argumento para guardar el wallpaper
#  con un nombre personalizado
# last: establece el ultimo wallpaper agregado a la lista
# debug: "libera los logs para el usuario" /no disponible de momento"
# clear: "termina todos los procesos relacionado a "linux-wallpaper"
# remove: "elimina el wallpaper basado en su id o nombre TODO: De momento  no disponible
export def set_wallpaper [ 
  number?: int
  --adding:string (-a)
  --random (-r)
  --display (-d) = "DP-1"
  --name:string (-n)
  --byname: string (-N)
  --last (-l)
  --debug
  --clear (-c)
  --remove:string (-R) = ""
] {
  job list | each {|job| job kill $job.id}
  let wallpaper_list_file =  ('~/mi_niri_flake/desktop/wallpaper/wallpaper_engine_links.csv' | path expand)
  if $number != null {
    let id = open $wallpaper_list_file | select id | get id | get $number
    print $"Set: (open $wallpaper_list_file | select name | get name | get $number)"
    print $"id: ($id)"
    job spawn {linux-wallpaperengine --screen-root $display $id}
  }

  # if $remove != null {
  #   let id = (get_id_w $remove)
  #   let w_item = open $wallpaper_list_file | where  name == $byname | get 0
  #   print $"Removing workshop name: ($w_item | get name)"
  #   let temp_file = $"($wallpaper_list_file).tmp"
  #   if $byname != null {
  #     open $wallpaper_list_file | where name != ($w_item.name) | to csv | save $temp_file --force
  #
  #   } else {
  #     open $wallpaper_list_file | where id != $id | to csv | save $temp_file --force
  #   }
  #   mv $temp_file $wallpaper_list_file
  #   print "Delete" $id
  # }
  #=====
  if $adding != null {
    mut name_steam_workshop = get_ws_steam $adding
    print $"Workshop Name: ($name_steam_workshop)"
    let id_workshop = (get_id_w $adding)
    if $byname != null {
      $name_steam_workshop = $byname
    }
    print $"Workshop id:($id_workshop)"
    print $"adding workshop item like: ($name_steam_workshop)"
    mut monitor_name = "null"
    if $display != null {
      $monitor_name = $display 
    }
    
    $"($name_steam_workshop),($monitor_name),(get_id_w $adding)\n"| save --append $wallpaper_list_file
    
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
    let total_lines = (open $wallpaper_list_file |select id | length )
    let r_number = random int 1..($total_lines - 1)
    print $"debug random number: ($r_number)"
    let id = (open $wallpaper_list_file |select id | get id | get ($r_number - 1))
    print $"workshop id: ($id)"
    # linux-wallpaperengine --screen-root $display $id
    job spawn {linux-wallpaperengine --screen-root $display $id}


  } 
  if $name != null {

    let name_w = open $wallpaper_list_file | where name == $name
    
    if ($name_w | length ) == 0 {
      print $"Wallpaper \"($name)\" not found"
    } else {
      let id: int = ($name_w | get id | get 0 | get_id_w | into int) 
      job spawn {linux-wallpaperengine --screen-root $display $id}
    }


  }

  if $last {
    let id_l = (open $wallpaper_list_file | last | select id | get id)
    print $"setting workshop item: ($id_l)"
    job spawn {
        linux-wallpaperengine --screen-root $display $id_l
    }
  }
}
