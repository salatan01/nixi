{ config, pkgs, ... }:

{
  # ==========================================
  # 1. System-Wide Gaming Optimizations
  # ==========================================

  # Switch to the Zen kernel for better desktop/gaming responsiveness and task scheduling
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Crucial for 8GB RAM: Enables compressed memory to prevent heavy disk swapping
  zramSwap = {
    enable = true;
    memoryPercent = 50; # Uses up to 4GB of your RAM as compressed swap space
  };


  # ==========================================
  # 2. Intel UHD 630 Graphics Acceleration
  # ==========================================

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # ==========================================
  # 3. Steam & Performance Tools
  # ==========================================

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true; # Micro-compositor for efficient upscaling
  };

  # Feral Interactive GameMode for CPU/GPU prioritization
  programs.gamemode.enable = true;

  # ==========================================
  # 4. Environment Variables & Extra Packages
  # ==========================================

  environment.sessionVariables = {
    INTEL_DEBUG = "noccs"; # Stability/performance tweak for Intel UHD graphics
    MESA_VK_WSI_PRESENT_MODE = "mailbox"; # Reduces tearing without VSync input lag
  };

  environment.systemPackages = with pkgs; [
    protonup-qt # GUI tool to install GE-Proton
    mangohud # Vital for monitoring your 8GB RAM and iGPU limits in-game
  ];
}
