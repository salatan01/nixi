{ config, pkgs, ... }:

{
  # Make sure the font is actually installed in your system/home profile
  home.packages = [
    pkgs.maple-mono.NF
  ];

  programs.kitty = {
    enable = true;

    # --- The Aesthetic Font Setup ---
    font = {
      name = "Maple Mono NF"; # Round, flowy, and supports all your icons
      size = 14;
    };

    settings = {
      # --- Warm & Sweet Smoked Glass ---
      background = "#16141a";
      background_opacity = "0.7";
      background_blur = "40";

      # --- Flowy Cursor Physics ---
      cursor_shape = "beam";
      cursor_trail = "5";
      cursor_trail_decay = "0.1 0.45";
      cursor_trail_start_threshold = "2";

      # --- Padding & Layout ---
      #window_padding_width = "22";
      confirm_os_window_close = "0";
      hide_window_decorations = "yes";

      # --- Typographic "Juice" ---
      disable_ligatures = "never"; # Essential for that "flowy" code look
      box_drawing_scale = "0.001, 1, 1.5, 2";
      undercurl_style = "thick-sparse"; # Makes error underlines look sexy

      # --- User Palette (Text & Accents) ---
      foreground = "#d6deeb";
      selection_background = "#5f7e97";
      selection_foreground = "#dfe5ee";
      cursor = "#7e57c2";
      cursor_text_color = "#16141a";

      # 16-Color Palette (Night Owl Inspired)
      color0 = "#011627";
      color1 = "#ef5350";
      color2 = "#22da6e";
      color3 = "#addb67";
      color4 = "#82aaff";
      color5 = "#c792ea";
      color6 = "#21c7a8";
      color7 = "#ffffff";
      color8 = "#575656";
      color9 = "#ef5350";
      color10 = "#22da6e";
      color11 = "#ffeb95";
      color12 = "#82aaff";
      color13 = "#c792ea";
      color14 = "#7fdbca";
      color15 = "#ffffff";
    };

    extraConfig = ''
      # Custom font features for Maple Mono (if you want those sweet ligatures)
      font_features MapleMono-NF +cv01 +ss01 +ss02 +ss03

      # Smooth mouse hiding
      mouse_hide_wait 3.0
    '';
  };
}
