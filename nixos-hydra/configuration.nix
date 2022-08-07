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

nix.extraOptions = ''experimental-features = nix-command flakes'';

  networking.hostName = "hydra"; # Define your hostname.
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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
          
          libinput.enable = true;
          enable = true;
          layout = "br";
          displayManager = {
                  gdm.enable = true;
          };
          desktopManager.gnome.enable = true;
          windowManager.awesome.enable = true;
          gdk-pixbuf.modulePackages = with pkgs; [ libwebp ];
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.liquuid = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
  # editors
     vim micro
  # tools
     killall lfs wget p7zip dstat tree gotop iotop gotop dstat htop dig inetutils ncftp nmap iptraf-ng wireshark openvpn jetbrains-mono compsize file
  # browsers
     firefox brave chromium
  # dev tools
     vscode git tig dbeaver insomnia go zeal android-studio ansible lens 
  # x11 apps
     xterm xorg.xinit alacritty xclip flameshot nitrogen terminator gdk-pixbuf
  # containers
     docker docker-compose
  # nodejs
     nodejs-16_x yarn deno
  # python
     python39Full python39Packages.ipython
  # music
     clementine lollypop lmms hydrogen
  # games 
     steam citra dolphin-emu yuzu
  # video tools
     obs-studio kdenlive mpv vlc ffmpegthumbs handbrake 
  # graphical tools
    gimp inkscape krita blender
  # office 
    wpsoffice zeal pdf2djvu minidjvu djvulibre djvu2pdf djview4
  # gnome stuff
     gnome3.adwaita-icon-theme
     gnome3.gnome-tweaks
     gnomeExtensions.appindicator
     dracula-theme
     gnome.gedit
     gthumb
     gnomeExtensions.syncthing-indicator
  # eng
     stlink stlink-gui fritzing logisim-evolution openscad cura qucs sigrok-cli
  # comunication
     teams discord remmina tdesktop anydesk
  # p2p
     transmission nextcloud-client syncthing
  # misc
     adoptopenjdk-bin
     libwebp
     flatpak
     distrobox
     virtualbox
     gnome.gnome-boxes
  # fonts 
    dejavu_fonts open-sans clearlyU cm_unicode corefonts powerline-fonts ankacoder fira-code fira-code-symbols fira-mono font-manager      
   
  ];
    programs.dconf.enable = true;
    virtualisation.docker.enable = true;
    programs.adb.enable = true;
    programs.zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" "adbusers" ];
      theme = "agnoster";
    };  


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

