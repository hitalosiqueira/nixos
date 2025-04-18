{ pkgs, config, ... }:

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
    deepin.deepin-wallpapers
    swaybg
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

  fonts.fontconfig.enable = true;

  programs.waybar = {
    enable = true;
    style = ''
          * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: UbuntuSans Nerd Font, sans-serif;
          font-size: 14px;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      /* you can set a style on hover for any module like this */
      #pulseaudio:hover {
          background-color: #a37800;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #power-profiles-daemon {
          padding-right: 15px;
      }

      #power-profiles-daemon.performance {
          background-color: #f53c3c;
          color: #ffffff;
      }

      #power-profiles-daemon.balanced {
          background-color: #2980b9;
          color: #ffffff;
      }

      #power-profiles-daemon.power-saver {
          background-color: #2ecc71;
          color: #000000;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
      }

      #network {
          background-color: #2980b9;
      }

      #network.disconnected {
          background-color: #f53c3c;
      }

      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #wireplumber {
          background-color: #fff0f5;
          color: #000000;
      }

      #wireplumber.muted {
          background-color: #f53c3c;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

      #privacy {
          padding: 0;
      }

      #privacy-item {
          padding: 0 5px;
          color: white;
      }

      #privacy-item.screenshare {
          background-color: #cf5700;
      }

      #privacy-item.audio-in {
          background-color: #1ca000;
      }

      #privacy-item.audio-out {
          background-color: #0069d4;
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
          "bluetooth"
        ];

        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          controller = "controller1"; # Replace with your actual controller name if needed
          on-click = "blueman-manager";
        };
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
    style = ''
      window {
        margin: 5px;
        background-color: rgba(30, 30, 46, 0.9); /* Transparent Mocha base */
        border-radius: 12px;
        font-family: "Inter", sans-serif;
        font-size: 14px;
      }

      #input {
        margin: 10px;
        padding: 6px 10px;
        border: none;
        border-radius: 8px;
        background-color: rgba(49, 50, 68, 0.8);
        color: #cdd6f4;
      }

      #inner-box {
        margin: 5px;
        padding: 4px;
        border-radius: 8px;
      }

      #outer-box {
        margin: 10px;
        padding: 10px;
      }

      #entry {
        padding: 6px 10px;
        margin: 4px;
        border-radius: 8px;
        color: #cdd6f4;
      }

      #entry:selected {
        background-color: rgba(137, 180, 250, 0.5);
        color: #1e1e2e;
      }
    '';
  };

  # xdg.configFile."wofi/style.css".source = ./wofi.css;

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

  home.file."wallpaper.png".source = ./wallhaven-qzwxgq_2560x1600.png;

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
      exec swaybg -i ${config.home.homeDirectory}/wallpaper.png -m fill
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
