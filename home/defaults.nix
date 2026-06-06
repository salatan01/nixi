{ pkgs, ... }:
{
  home.file.".face" = {
    source = ./assets/user/.face;
  };
  # Yazi configuration
  programs.yazi = {
    enable = true;
    shellWrapperName = "y"; # ← ADD THIS LINE TO FIX THE WARNING

    settings = {
      manager = {
        show_hidden = false;
      };
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
          }
        ];
        open = [
          { run = ''xdg-open "$@"''; }
        ];
        reveal = [
          { run = ''nemo "$@"''; }
        ];
        view-image = [
          { run = ''nomacs "$@"''; }
        ];
      };
      open.rules = [
        {
          mime = "text/*";
          use = "edit";
        }
        {
          mime = "application/json";
          use = "edit";
        }
        {
          mime = "application/toml";
          use = "edit";
        }
        {
          mime = "image/*";
          use = "view-image";
        }
        {
          mime = "application/pdf";
          use = "open";
        }
        {
          mime = "video/*";
          use = "open";
        }
        {
          mime = "inode/directory";
          use = "reveal";
        }
        {
          mime = "*";
          use = "open";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    nemo-with-extensions
    nomacs
    kdePackages.okular
    glib
    xcolor
    webp-pixbuf-loader
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "nemo.desktop";
      "application/pdf" = "org.kde.okular.desktop";

      # --- WEB BROWSER DEFAULTS ---
      "text/html" = "brave-browser.desktop";
      "text/xml" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop"; # Handles http:// links
      "x-scheme-handler/https" = "brave-browser.desktop"; # Handles https:// links
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
      # ----------------------------

      "video/*" = "mpv.desktop";
      "text/plain" = "nvim.desktop";
      "image/jpeg" = "org.nomacs.ImageLounge.desktop";
      "image/png" = "org.nomacs.ImageLounge.desktop";
      "image/gif" = "org.nomacs.ImageLounge.desktop";
      "image/webp" = "org.nomacs.ImageLounge.desktop";
      "image/bmp" = "org.nomacs.ImageLounge.desktop";
      "image/tiff" = "org.nomacs.ImageLounge.desktop";
      "image/*" = "org.nomacs.ImageLounge.desktop";
    };
  };

  home.sessionVariables = {
    GDK_BACKEND = "wayland";
    GTK_THEME = "Adwaita:dark";
    EDITOR = "nvim"; # ← also set this so yazi's fallback is nvim not nano
    VISUAL = "nvim";
  };
}
