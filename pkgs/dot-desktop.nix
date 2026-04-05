{pkgs, ...}: let
  whatsappIcon = pkgs.fetchurl {
    url = "https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg";
    sha256 = "sha256-3WpNssOUyhGqirCHNp8vUKEub4dOSdt7HVYJ0Kj7KMo=";
  };
in {
  # whatsapp .desktop
  home.file.".local/share/applications/whatsapp.desktop".text = ''
    [Desktop Entry]
    Name=WhatsApp
    Exec=chromium --app=https://web.whatsapp.com
    Icon=whatsapp
    Terminal=false
    Type=Application
    Categories=Network;InstantMessaging;
  '';
  home.file.".local/share/icons/hicolor/scalable/apps/whatsapp.svg".source = whatsappIcon;
  #-----
}
