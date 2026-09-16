{...}: {
  services.pihole-ftl = {
    enable = true;
    settings = {
      # see <https://docs.pi-hole.net/ftldns/configfile/>

      # external dns servers quad9 and cloudflare
      dns.upstreams = ["9.9.9.9" "1.1.1.1"];

      # optionally resolve local hosts (domain is optional)
      dns.hosts = ["192.168.1.188 hostname.domain"];
      dns.listeningMode = "BIND";
      dns.interface = "enp6s0"; # ej: enp3s0, wlan0
    };
  };
  systemd.services.pihole-ftl = {
    after = ["network-online.target"];
    wants = ["network-online.target"];
  };

  systemd.network.wait-online.enable = true;

  services.pihole-web = {
    enable = true;
    ports = ["8443s"];
  };
}
