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
    nerd-fonts.ubuntu-sans
    pavucontrol
    playerctl
    htop
  ];

  systemd.user.services.playerctld = {
    Unit = {
      Description = "MPRIS controller daemon";
      After = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.playerctl}/bin/playerctld";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.startServices = "sd-switch";

  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: "Ubuntu Sans Nerd Font", sans-serif;
        font-size: 14px;
      }
    '';
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
          "mpris"
        ];
        modules-right = [
          "pulseaudio"
          "battery"
          "cpu"
          "memory"
          "network"
          "clock"
        ];

        "cpu" = {
          format = " {usage}%";
          interval = 1;
          max-length = 10;
        };

        "memory" = {
          format = " {used:0.1f}G / {total:0.1f}G";
          interval = 3;
          on-click = "kitty htop";
        };
        "mpris" = {
          player = "spotify";
          format = "{artist} - {title}";
          format-paused = " {artist} - {title}";
          format-stopped = "";
          interval = 1;
        };

        "clock" = {
          interval = 60;
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
          timezone = "local";
        };

        "pulseaudio" = {
          format = "{volume}% ";
          format-muted = " muted";
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        "battery" = {
          bat = "BAT0"; # Change to BAT1 if needed
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ⚡";
          format-plugged = "{capacity}% 🔌";
          format-alt = "{time}";

          # Optional icons
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ]; # Nerd Font battery icons
          tooltip = true;
          interval = 30;
        };

        "network" = {
          format-wifi = "  {essid} ({signalStrength}%)";
          format-ethernet = "  {ifname}";
          format-disconnected = "  Disconnected";
          tooltip = true;
          on-click = "kitty -e nmtui-connect";
          tooltip-format = "{ifname} via {gwaddr}\nIPv4: {ipaddr}\nIPv6: {ip6addr}";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
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
