{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix

    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/de.nix
    ./modules/gfonts.nix
    ./modules/inputs.nix
    ./modules/pkgs.nix
    ./modules/services.nix
    # ./modules/steam.nix

  ];

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nightkat01 = {
    isNormalUser = true;
    description = "SulTan Mahmud";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11"; # Did you read the comment?

}
