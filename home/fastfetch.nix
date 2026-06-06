{ config, pkgs, ... }:

{
  # Keep the assets symlinked
  xdg.configFile."fastfetch/assets".source = ./assets;

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        # This shell command picks a random file from the directory
        source = "$(find ${config.xdg.configHome}/fastfetch/assets/fflogo -type f | shuf -n 1)";
        type = "kitty";
        width = 31;
        height = 14;
        padding = {
          top = 1;
          left = 3;
        };
      };

      display = {
        separator = "";
        color = {
          keys = "blue";
          title = "cyan";
        };
      };

      modules = [
        "title"
        {
          type = "os";
          key = "OS      ⚡ ";
          format = "NixOS {version}";
        }
        {
          type = "kernel";
          key = "Kernel  ⚡ ";
        }
        {
          type = "packages";
          key = "Pkgs    ⚡ ";
        }
        {
          type = "uptime";
          key = "Uptime  ⚡ ";
        }
        {
          type = "command";
          key = "Age     ⚡ ";
          shell = "/bin/sh";
          text = "birth=$(stat -c %Y /nix/var/nix/profiles/system-1-link 2>/dev/null || stat -c %Y /); now=$(date +%s); echo $(((now - birth) / 86400)) days";
        }
        "break"
        {
          type = "shell";
          key = "Shell   ⚡ ";
        }
        {
          type = "cpu";
          key = "CPU     ⚡ ";
        }
        {
          type = "gpu";
          key = "GPU     ⚡ ";
        }
        {
          type = "memory";
          key = "RAM     ⚡ ";
        }
        "break"
        {
          type = "custom";
          format = "{#34}One step at a time";
          key = "          ";
        }
        {
          type = "custom";
          format = "{#34}No matter how long it takes";
          key = "          ";
        }
        {
          type = "custom";
          format = "{#36}I will make the climb";
          key = "          ";
        }
        {
          type = "custom";
          format = "{#36}Learn from the mistakes I've made";
          key = "          ";
        }
        {
          type = "custom";
          format = "{#1}  - ONE OK ROCK";
          key = "          ";
        }
      ];
    };
  };
}
