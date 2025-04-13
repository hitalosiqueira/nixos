{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3 = {
      enable = true;
      extraConfig = ''
        # Your custom i3 config here
        bindsym $mod+d exec rofi -show drun
        font pango:monospace 14
        exec --no-startup-id nm-applet
        # More i3 customizations...
      '';
    };

    dpi = 192;
  };
  services.displayManager.defaultSession = "xfce+i3";
}
