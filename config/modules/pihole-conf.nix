{...}: {
  services.pihole-ftl = {
    enable = true;
    settings = {
      # See <https://docs.pi-hole.net/ftldns/configfile/>

      # External DNS Servers quad9 and cloudflare
      dns.upstreams = ["9.9.9.9" "1.1.1.1"];

      # Optionally resolve local hosts (domain is optional)
      dns.hosts = ["192.168.1.188 hostname.domain"];
    };

  };

  services.pihole-web = {
    enable = true;
    ports = ["443s"];
  };
}
