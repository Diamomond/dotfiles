{ config, lib, pkgs, ... }:

{
  # 1. SearXNG Configuration
  services.searx = {
    enable = true; # Changed from false to true
    redisCreateLocally = true;
    runInUwsgi = true;

    uwsgiConfig = {
      socket = "/run/searx/searx.sock";
      chmod-socket = "660";
    };

    settings = {
      general = {
        debug = false;
        instance_name = "searx";
        enable_metrics = true;
      };

      ui = {
        static_use_hash = true;
        default_locale = "en";
        query_in_title = true;
        infinite_scroll = true;
        center_alignment = true;
        default_theme = "simple";
        theme_args.simple_style = "auto";
      };

      search = {
        safe_search = 0; # 0 = None, 1 = Moderate, 2 = Strict
        autocomplete = "google";
        favicon_resolver= "google";
      };

      server = {
        base_url = "http://yuki.local"; 
        port = 8888;
        bind_address = "127.0.0.1";
        
        # For a strictly private home network, hardcoding a random string here is usually fine.
        # Just mash your keyboard to replace this string.
        secret_key = "thisisarandomstringusedbyme";
        
        limiter = false; # Disabled: No need to rate-limit yourself on a local network
        public_instance = false; # Disabled: Prevents bots from abusing your instance
        image_proxy = true;
        method = "GET";
      };

      # You can paste your massive engines list here. 
      # I've omitted the giant list for readability, but your original list is perfectly fine.
   engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
      "duckduckgo".disabled = false;
      "google".disable=false;
      "brave".disabled = true;
      "bing".disabled = true;
      "mojeek".disabled = true;
      "mwmbl".disabled = false;
      "mwmbl".weight = 0.4;
      "qwant".disabled = true;
      "crowdview".disabled = false;
      "crowdview".weight = 0.5;
      "curlie".disabled = true;
      "ddg definitions".disabled = false;
      "ddg definitions".weight = 2;
      "wikibooks".disabled = false;
      "wikidata".disabled = false;
      "wikiquote".disabled = false;
      "wikisource".disabled = false;
      "wikispecies".disabled = false;
      "wikispecies".weight = 0.5;
      "wikiversity".disabled = false;
      "wikiversity".weight = 0.5;
      "wikivoyage".disabled = false;
      "wikivoyage".weight = 0.5;
      "currency".disabled = false;
      "dictzone".disabled = false;
      "lingva".disabled = true;
      "bing images".disabled = false;
      "brave.images".disabled = true;
      "duckduckgo images".disabled = true;
      "google images".disabled = false;
      "qwant images".disabled = true;
      "1x".disabled = true;
      "artic".disabled = false;
      "deviantart".disabled = false;
      "flickr".disabled = true;
      "imgur".disabled = false;
      "library of congress".disabled = false;
      "material icons".disabled = true;
      "material icons".weight = 0.2;
      "openverse".disabled = false;
      "pinterest".disabled = false;
      "svgrepo".disabled = false;
      "unsplash".disabled = false;
      "wallhaven".disabled = false;
      "wikicommons.images".disabled = false;
      "yacy images".disabled = true;
      "bing videos".disabled = false;
      "brave.videos".disabled = true;
      "duckduckgo videos".disabled = true;
      "google videos".disabled = false;
      "qwant videos".disabled = false;
      "dailymotion".disabled = true;
      "google play movies".disabled = true;
      "invidious".disabled = true;
      "odysee".disabled = true;
      "peertube".disabled = false;
      "piped".disabled = true;
      "rumble".disabled = false;
      "sepiasearch".disabled = false;
      "vimeo".disabled = true;
      "youtube".disabled = false;
      "brave.news".disabled = true;
      "google news".disabled = false;
    };
    };
  };

  # 2. Permissions
  # Allows Nginx to read the SearX uWSGI socket
  users.groups.searx.members = ["nginx"];

  # 3. Open Firewall
  networking.firewall.allowedTCPPorts = [ 80 ];

  # 4. Nginx Reverse Proxy
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    
    virtualHosts = {
      # The "_" acts as a catch-all. It will respond to whatever local IP 
      # or hostname you use to access this machine.
      "_" = {
        default = true;
        locations = {
          "/" = {
            extraConfig = ''
              uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
            '';
          };
        };
      };
    };
  };
}
