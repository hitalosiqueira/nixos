{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.plasma;
in
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  options.plasma = {
    enable = lib.mkEnableOption "Plasma setup";

    terminal = lib.mkOption {
      type = lib.types.str;
      default = "konsole";
    };

    browser = lib.mkOption {
      type = lib.types.str;
      default = "firefox";
    };

    launcher = lib.mkOption {
      type = lib.types.str;
      default = "krunner";
    };

    workspaces = lib.mkOption {
      type = lib.types.int;
      default = 10;
    };

  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
      };

      configFile.kdeglobals.KDE = {
        AnimationDurationFactor = 0;
      };

      shortcuts.org_kde_powerdevil = {
        "powerProfile" = "";
      };

      shortcuts.kwin = {
        # Switch workspaces
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        # Move active window
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Desktop 10" = "Meta+)";

        "Window Close" = "Meta+Q";

        # Focus windows
        "Switch Window Left" = "Meta+H";
        "Switch Window Down" = "Meta+J";
        "Switch Window Up" = "Meta+K";
        "Switch Window Right" = "Meta+L";

        "Overview" = "Meta+Space";

        "Window Quick Tile Left" = "Meta+Shift+H";
        "Window Quick Tile Right" = "Meta+Shift+L";
        "Window Quick Tile Top" = "Meta+Shift+K";
        "Window Quick Tile Down" = "Meta+Shift+J";
        "Window Maximize" = "Meta+Shift+F";

        "Show Desktop" = "";
        "Move Window Left" = "";
        "Move Window Right" = "";
        "Move Window Up" = "";
        "Move Window Down" = "";

      };
      shortcuts.plasmashell = {
        "activate task manager entry 1" = "";
        "activate task manager entry 2" = "";
        "activate task manager entry 3" = "";
        "activate task manager entry 4" = "";
        "activate task manager entry 5" = "";
        "activate task manager entry 6" = "";
        "activate task manager entry 7" = "";
        "activate task manager entry 8" = "";
        "activate task manager entry 9" = "";
        "activate task manager entry 10" = "";
      };
      shortcuts.ksmserver = {
        "Lock Session" = [
          "Meta+Esc"
          "Screensaver"
        ];
      };

      #
      # Launchers
      #
      hotkeys.commands = {
        terminal = {
          name = "Terminal";
          key = "Meta+Return";
          command = cfg.terminal;
        };

        browser = {
          name = "Browser";
          key = "Meta+B";
          command = cfg.browser;
        };

        launcher = {
          name = "Launcher";
          key = "Meta+D";
          command = "krunner";
        };
      };

      configFile.krunnerrc = {
        General = {
          FreeFloating = true;
          historyBehavior = "Disabled";
        };

        Plugins = {
          browserhistoryEnabled = false;
          browsertabsEnabled = false;
          calculatorEnabled = true;
          krunner_appstreamEnabled = true;
          krunner_bookmarksrunnerEnabled = false;
          krunner_katesessionsEnabled = false;
          krunner_konsoleprofilesEnabled = false;
          krunner_locationsrunnerEnabled = false;
          krunner_recentdocumentsEnabled = false;
          krunner_sessionsEnabled = false;
          krunner_shellEnabled = true;
          krunner_systemsettingsEnabled = true;
          krunner_webshortcutsEnabled = false;
          windowsEnabled = true;
        };
      };

      configFile.kwinrc = {
        Windows = {
          BorderlessMaximizedWindows = false;
          Placement = "Maximizing";
        };

        Desktops = {
          Number = cfg.workspaces;
        };

      };
    };
  };
}
