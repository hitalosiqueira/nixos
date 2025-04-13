{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    waybar
    grim
    slurp
    xwayland
    inter
    orchis-theme
    adwaita-icon-theme

  ];

  programs.wofi = {
    enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita"; # or "Bibata-Modern-Ice", etc.
    XCURSOR_SIZE = "24";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      size = 24;
    };
    theme.name = "Orchis-Dark";
    font.name = "Inter";
    gtk3.extraConfig = {
      Settings = ''
        			gtk-application-prefer-dark-theme=1
        			gtk-font-name=Inter
        		'';
    };

    gtk4.extraConfig = {
      Settings = ''
        			gtk-application-prefer-dark-theme=1
        			gkt-font-name=Inter
        		'';
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show drun";
    };
    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export XDG_CURRENT_DESKTOP=sway
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_USE_XINPUT2=1
      export QT_QPA_PLATFORM=wayland
      export QT_SCALE_FACTOR=1
      export GDK_SCALE=1
      export GDK_DPI_SCALE=1
    '';
    extraConfig = ''
      exec swaymsg workspace 1
      output * scale 1.5
      default_border none
      default_floating_border none
      titlebar_padding 1
      titlebar_border_thickness 0
      seat * xcursor_theme Adwaita 24
    '';
    wrapperFeatures.gtk = true; # For launching GTK apps from sway
  };
}
