#                                                         Commonpkgs
#                                                         PKGS

{
  pkgs,
  unstable,
  pinned,
  inputs,
  old,
  ...
}:
{
  #################--------------------FlatPacks-------------------#########################
  services.flatpak = {
    enable = true;
  };

  ##################------------------Unfree Pkgs-----------------#########################

  nixpkgs.config.allowUnfree = true;

  ##################------------------Pkg Modules-----------------#########################

  services.cloudflare-warp = {
    enable = true;
    # certificate = ./Cloudflare_CA.pem;
  };

  # --- documentation
  documentation.man.enable = true;
  documentation.dev.enable = true; # Often where 'as' docs hide

  # --- Stable
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add common libraries that unpatched binaries usually look for
    stdenv.cc.cc
    zlib
    glib
    # libX11
  ];
  programs.neovim.enable = true;
  programs.nano.enable = false;
  programs.firefox.enable = true;

  programs.partition-manager.enable = true;
  programs.zsh.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true; # Optimized for flakes
  programs.nh.enable = true;

  # --- Unstable

  # --- Pinned

  # --- Flaked

  ##################------------------Pkg Environment-----------------#########################

  environment.systemPackages = with pkgs; [

    ##################------------------Stable-----------------#########################

    # =====================================================================
    # --- GUI Apps
    # =====================================================================

    # --- 🌐 Web & Internet
    brave
    android-tools
    chromium
    motrix
    proton-vpn
    unstable.gemini-cli

    # --- 💻 Terminals
    alacritty
    ghostty
    kitty

    # --- ✍️ Productivity & Writing
    kdePackages.ghostwriter
    zed-editor
    unstable.notesnook
    obsidian

    # --- 🎬 Media & Audio
    imv
    mpd
    mpv
    obs-studio
    spotify

    # --- 🎨 Desktop & Wayland Setup
    bibata-cursors
    libxcb
    smile
    old.swww

    # --- 🎮 Gaming
    steam-run

    # =====================================================================
    # --- CLI Tools
    # =====================================================================

    # --- 🛠️ Core Utilities & Modern Unix
    wl-clipboard
    bat
    btop
    duf
    dust
    tealdeer
    delta
    fd
    fastfetch
    file
    fzf
    ripgrep
    grex
    sd
    tmux
    tree
    wget
    zoxide

    # --- ⌨️ Development & Editors
    gcc
    gh
    git
    lazygit
    gnumake
    nodejs
    tree-sitter

    # --- ❄️ Nix OS Tools
    nix-output-monitor
    nix-search-cli
    nvd
    statix

    # --- 🛡️ System & Filesystem Management
    bubblewrap
    dosfstools # Provides fatfsck, mkfs.vfat, etc.
    mtools # Utilities for manipulating MS-DOS filesystems
    unzip
    zip

    # --- 🎵 Media, Processing & Fun
    ani-cli
    cava
    chafa
    exiftool
    ffmpeg
    imagemagick
    yt-dlp

    # --- 🚀 Shell Enhancements
    starship

    ##################------------------Unstable-----------------#########################

    # =====================================================================
    # --- Lsp Tools
    # =====================================================================

    # --- 🦀 C/C++ & Rust
    unstable.clang-tools # C/C++ (includes clangd)
    unstable.rust-analyzer
    qt6.qtdeclarative # This provides qmlls

    # --- 🐍 Python
    unstable.pyright # Python

    # --- ❄️ Nix
    unstable.alejandra
    unstable.nixd
    unstable.nixfmt

    # --- 📜 Bash & Markdown
    unstable.marksman # Markdown
    unstable.shellcheck # Bash linter
    unstable.shfmt # Bash formatter

    # =====================================================================
    # --- GUI Apps
    # =====================================================================

    unstable.stretchly
    inputs.parallex.packages.${pkgs.system}.default

    # =====================================================================
    # --- CLI Tools
    # =====================================================================

    ##################------------------Pinned-----------------#########################

    # =====================================================================
    # --- GUI Apps
    # =====================================================================

    # =====================================================================
    # --- CLI Tools
    # =====================================================================

  ];
}
