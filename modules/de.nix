{ pkgs, config, ... }:
{
  # Ensure dconf is enabled so GNOME can store its settings state
  programs.dconf.enable = true;

  # Ensure the GNOME settings daemon and portals are functioning
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.enable = false;
  services.xserver.desktopManager.cinnamon.enable = false;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
}
