{ pkgs, ... }:

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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
        ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "wlr/taskbar"
        ];
        modules-center = [
          "sway/window"
          "custom/hello-from-waybar"
        ];
        modules-right = [
          "mpd"
          "custom/mymodule#with-css-id"
          "temperature"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
  };

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
      bars = [ ];
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
      exec waybar
      output * scale 1.5
      default_border none
      default_floating_border none
      titlebar_padding 1
      titlebar_border_thickness 0
      seat * xcursor_theme Adwaita 24

      # Brightness
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      # Volume
      bindsym XF86AudioRaiseVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'
      bindsym XF86AudioLowerVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'
      bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'

    '';
    wrapperFeatures.gtk = true; # For launching GTK apps from sway
  };
}
