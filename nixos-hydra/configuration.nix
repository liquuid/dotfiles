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
  networking.interfaces.enp27s0.ipv4.addresses = [ {
    address = "192.168.0.100";
    prefixLength = 24;
  } ] ;
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ]; 
  hardware.enableAllFirmware = true;
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
 
  services.flatpak.enable=true;  
  
  # Enable the X11 windowing system.
  services.xserver = {
          
          libinput.enable = true;
          enable = true;
          layout = "br";
          displayManager = {
                  gdm.enable = true;
          };
          desktopManager.plasma5.enable = true;
          desktopManager.gnome.enable = true;
	  #desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
	  #	khelpcenter
          #		print-manager
	  #	ksshaskpass
	  #];
          desktopManager.cde.enable = true;
          desktopManager.enlightenment.enable = true;


          windowManager.awesome.enable = true;
          gdk-pixbuf.modulePackages = with pkgs; [ libwebp ];
  };

  services.gnome.evolution-data-server.enable = true;
  # optional to use google/nextcloud calendar
  services.gnome.gnome-online-accounts.enable = true;
  # optional to use google/nextcloud calendar
  services.gnome.gnome-keyring.enable = true;

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  #ixpkgs.config.pulseaudio = true;
  #hardware.pulseaudio = {
  # enable = true;
  # package = pkgs.pulseaudioFull;
  # support32Bit = true;
  #};
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
hardware.bluetooth.settings = {
  General = {
    Enable = "Source,Sink,Media,Socket";
  };
};
 
  users.users.liquuid = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "dialout" "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };
  users.extraGroups.vboxusers.members = [ "liquuid" ];
  #programs.steam = {
  #
  #  enable = true;
  #  remotePlay.openFirewall = true;
  #  dedicatedServer.openFirewall = true;
  #};
  environment.systemPackages = with pkgs; [
  # editors
     vim micro
  # tools
     killall lfs wget p7zip dstat tree gotop iotop gotop dstat htop dig ncftp nmap iptraf-ng wireshark openvpn jetbrains-mono compsize file nixos-option usbutils unrar 
  # browsers
     firefox brave google-chrome
  # dev tools
    arduino vscode git tig dbeaver insomnia go zeal android-studio ansible lens logisim-evolution 
  # x11 apps
     xterm xorg.xinit alacritty xclip flameshot nitrogen terminator gdk-pixbuf
  # containers
     docker docker-compose
  # nodejs
     nodejs-16_x yarn deno
  # python
     python39Full python39Packages.ipython python39Packages.pandas
  # music
     clementine lollypop lmms hydrogen kid3
  # games 
    citra dolphin-emu yuzu # steam-run
  # video tools
     obs-studio kdenlive mpv vlc ffmpegthumbs handbrake ffmpeg-full handbrake
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
     sshfs
     #foliate
  # eng
     # stlink stlink-gui 
     fritzing logisim-evolution openscad cura qucs sigrok-cli pulseview
  # comunication
     teams discord remmina tdesktop anydesk strongswan networkmanager_strongswan
  # p2p
     transmission-gtk nextcloud-client syncthing 
  # misc
     pcsctools
     pcsclite
     scmccid
     adoptopenjdk-bin
     libwebp
     distrobox
     gnome.gnome-boxes
     sshpass
     heroku
     appflowy
     #dduper
     ghostscript
     woeusb
    plasma5Packages.kdegraphics-thumbnailers
  # fonts 
    dejavu_fonts open-sans clearlyU cm_unicode corefonts powerline-fonts ankacoder fira-code fira-code-symbols fira-mono font-manager     
     
   
  ];
    programs.dconf.enable = true;
    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;

  
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
    services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *      root    date >> /tmp/cron.log"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 8080 ];
  networking.firewall.allowedUDPPorts = [ 8000 8080 ];
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

