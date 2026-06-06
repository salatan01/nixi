#                                                        Nixi
#                                                   SERVICES MODULE                                                            #
{
  config,
  pkgs,
  unstable,
  pinned,
  ...
}:
{
  ####################--------------------Networking & Bluetooth--------------------####################
  # --- Networking
  #    networking.hostName = "nixi";      Already specified in nixi/default.nix
  networking.networkmanager.enable = true;

  # --- Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # Helps with modern Sony/Bose headphones
      };
    };
  };
  # services.blueman.enable = true;

  ####################--------------------Disks & Storage--------------------####################
  # --- SSD Maintenance ---
  services.fstrim.enable = true;

  # Auto-optimizes the Nix store to save SSD space
  nix.settings.auto-optimise-store = true;

  services.devmon.enable = true; # Auto-mount daemon for removable devices

  # --- Printing & Discovery ---
  services.printing.enable = false;
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Resolve "printer.local" / "macbook.local" style hostnames
    openFirewall = true;
  };

  hardware.graphics.enable = true;
}
