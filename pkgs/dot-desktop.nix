{pkgs, ...}: let
  whatsappIcon = pkgs.fetchurl {
    url = "https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg";
    sha256 = "sha256-3WpNssOUyhGqirCHNp8vUKEub4dOSdt7HVYJ0Kj7KMo=";
  };
in {
  home.file = {
    ".local/share/icons/hicolor/scalable/apps/kindleIcon.svg".source = ./desktop/icons/kindleIcon.svg;
  };
  # whatsapp .desktop
  home.file.".local/share/applications/whatsapp.desktop".text = ''
    [Desktop Entry]
    Name=WhatsApp
    Exec=chromium --app=https://web.whatsapp.com
    Icon=${whatsappIcon}
    Terminal=false
    Type=Application
    Categories=Network;InstantMessaging;
  '';
  home.file.".local/share/applications/kindle.desktop".text = ''
    [Desktop Entry]
    Name=Kindle
    Exec=chromium --app=https://read.amazon.com/kindle-library
    Icon=kindleIcon
    Terminal=false
    Type=Application
    Categories=Office;
  '';
}
