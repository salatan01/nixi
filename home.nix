# home.nix
{
  config,
  pkgs,
  unstable,
  pinned,
  inputs,
  ...
}:
{
  # Added 'inputs' here

  home.username = "nightkat01";
  home.homeDirectory = "/home/nightkat01";
  home.stateVersion = "25.11";

  imports = [
    # This line is the "bridge" that connects the nvf flake to your config
    inputs.nvf.homeManagerModules.default
    #    inputs.niri.homeManagerModules.default
    ./home/defaults.nix
    ./home/fastfetch.nix
    ./home/ghostty.nix
    # ./home/git.nix
    ./home/kitty.nix
    ./home/librewolf.nix
    ./home/nvf.nix
    ./home/starship.nix
    ./home/wrappers.nix
    ./home/zsh.nix

  ];

  home.packages = [
    pkgs.atool
    pkgs.httpie
    pkgs.eza
    pkgs.zoxide
    pkgs.kdePackages.qtdeclarative
  ];

  qt.enable = true;
  programs.home-manager.enable = true;
  programs.quickshell.enable = true;
}
