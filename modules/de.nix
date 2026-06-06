{ pkgs, config, ... }:
{

  services.xserver.enable = false;
  services.xserver.desktopManager.cinnamon.enable = false;
  services.desktopManager.gnome.enable = false;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
}
