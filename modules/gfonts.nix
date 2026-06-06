#                                                        Common
#                                                     PKG CONFIGS

{
  config,
  pkgs,
  pinned,
  unstable,
  ...
}:
{

  # #################------------------Fonts ----------------#########################

  # 4. MOVED: Fonts are now in the correct place
  fonts.packages = with pkgs; [
    ubuntu-sans
    ubuntu-sans-mono
    nerd-fonts.jetbrains-mono
    # google-fonts
    #   font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    lohit-fonts.bengali # Moved from systemPackages
  ];

  # This ensures the system picks ubuntu as defualt fonts
  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [ "Ubuntu Sans" ];
      monospace = [ "Ubuntu Sans Mono" ];
    };
  };

}
