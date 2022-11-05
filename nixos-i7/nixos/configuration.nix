# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config.allowUnfree = true;

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


 nix.extraOptions = ''experimental-features = nix-command flakes'';

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #boot.loader.grub = {
  #  enable = true;
  #  device = "nodev";
  #  version = 2;
  #  efiSupport = true;
  #  enableCryptodisk = true;
  #};
  
  #boot.initrd = {
  #  luks.devices."root" = {
  #    device = "/dev/disk/by-uuid/dbedef81-d644-43e1-8534-b263fa23c53a";  
  #    preLVM = true;
  #    keyFile = "/keyfile.bin";
  #    allowDiscards = true;
  #  };
  #  secrets = {
      # Create /mnt/etc/secrets/initrd directory and copy keys to it
  #    "keyfile.bin" = "/etc/secrets/initrd/keyfile.bin";
  #  };
#};


  networking.hostName = "vaio-i7"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  #console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "br";
  #   useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Enable the X11 windowing system.
  
  services.xserver = {
          
          libinput.enable = true;
          enable = true;
          videoDrivers = [ "intel" ];
          layout = "br";
          displayManager = {
                  gdm.enable = true;
          };
          desktopManager.gnome.enable = true;
          windowManager.awesome.enable = true;
  };


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };  

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
  General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  users.users.liquuid = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "adbusers" "wheel" "docker" ]; 
  };
  
  environment.systemPackages = with pkgs; [
  # editors
     vim micro
  # tools
     btrfs-progs compsize wget p7zip dstat tree gotop iotop gotop dstat htop nmap iptraf-ng wireshark openvpn jetbrains-mono 
  # browsers
     firefox brave chromium
  # dev tools
     meld vscode git tig dbeaver insomnia go zeal android-studio
  # x11 apps
     xterm xorg.xinit alacritty xclip flameshot nitrogen terminator
  # containers
     docker docker-compose
  # nodejs
     nodejs-16_x yarn deno
  # python
     python39Full python39Packages.ipython
  # music
     clementine lollypop lmms hydrogen kid3
  # games 
     #steam citra dolphin-emu
  # video tools
     obs-studio kdenlive mpv vlc ffmpegthumbs handbrake ffmpeg-full 
  # graphical tools
    gimp inkscape krita blender
  # office 
    wpsoffice zeal
  # gnome stuff
     gnome3.adwaita-icon-theme
     gnome3.gnome-tweaks
     gnomeExtensions.appindicator
     dracula-theme
     gnome.gedit
     gthumb
     gnomeExtensions.syncthing-indicator
  # eng
     stlink stlink-gui fritzing logisim-evolution openscad cura qucs-s sigrok-cli pulseview
  # comunication
     teams discord remmina tdesktop anydesk
  # p2p
     transmission nextcloud-client syncthing
  # misc
     adoptopenjdk-bin
     libwebp
     distrobox
     gnome.gnome-boxes
     dmidecode
     hwinfo 
     sshfs
     scrcpy
     lfs
     woeusb
     foliate
  ];
    programs.dconf.enable = true;
    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
    programs.adb.enable = true;
    programs.zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" "adbusers" ];
      theme = "agnoster";
    };  


  services.openssh.enable = true;

  services.accounts-daemon.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  environment.variables = {
    # Set sandbox variable for gnome accounts to work
    WEBKIT_FORCE_SANDBOX = "0";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

