{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/greetd.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "hsiq" ];

  networking.hostName = "nixos"; # Define your hostname.

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config = {
      common = {
        default = "wlr";
      };
    };
  };

  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
        # Everything but the ID section:
        settings = {
          # The main layer, if you choose to declare it in Nix
          main = {
            capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
          };
          otherlayer = { };
        };
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
        '';
      };
    };
  };

  hardware.enableAllFirmware = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.light.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  #make zsh the default shell
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable opengl
  hardware.graphics.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.polkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hsiq = {
    isNormalUser = true;
    description = "Hitalo Siqueira";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "hsiq" = import ./home.nix;
    };
  };

  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  # enable notifications deamon
  # systemd.user.services.kanshi = {
  #   description = "kanshi daemon";
  #   environment = {
  #     WAYLAND_DISPLAY="wayland-1";
  #     DISPLAY = ":0";
  #   };
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
