{...}: {
  services.pihole-ftl = {
    enable = true;
    settings = {
      # see <https://docs.pi-hole.net/ftldns/configfile/>

      # external dns servers quad9 and cloudflare
      dns.upstreams = ["9.9.9.9" "1.1.1.1"];

      # optionally resolve local hosts (domain is optional)
      dns.hosts = ["192.168.1.188 hostname.domain"];
      dns.listeningMode = "LOCAL";
      # dns.interface = "enp6s0"; # ej: enp3s0, wlan0
    };
  };

  services.pihole-web = {
    enable = true;
    ports = ["8443s"];
  };
}
