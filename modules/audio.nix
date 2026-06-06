{
  config,
  pkgs,
  lib,
  ...
}:

{
  # ==========================================================
  # REALTIME SCHEDULING
  # Essential for preventing audio dropouts under heavy CPU load
  # ==========================================================
  security.rtkit.enable = true;

  # ==========================================================
  # PIPEWIRE CORE
  # ==========================================================
  services.pipewire = {
    enable = true;

    # Session manager
    wireplumber.enable = true;

    # Compatibility layers
    alsa.enable = true;
    alsa.support32Bit = true; # Required for older games/Wine
    pulse.enable = true;
    jack.enable = true;

    # ==========================================================
    # PERFORMANCE TWEAKS
    # Custom clock rates and buffer sizes to ensure stable
    # playback during heavy multitasking and compilation
    # ==========================================================
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  # ==========================================================
  # AUDIO UTILITIES
  # Essential graphical tools for routing and volume control
  # ==========================================================
  environment.systemPackages = with pkgs; [
    pavucontrol # Standard GTK volume control
    qpwgraph # Visual node-based routing for PipeWire (like Helvum)
    easyeffects # Advanced EQ, noise reduction, and compression
  ];
}
