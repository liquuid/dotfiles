# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6e5b74c3-b8af-411b-b5b5-40fb8f95835f";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
  };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6e5b74c3-b8af-411b-b5b5-40fb8f95835f";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };
  fileSystems."/boot/" = 
  { device = "/dev/sdb1";
     fsType = "vfat";
  };
  fileSystems."/storage/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@storage"];	
  };
  fileSystems."/storage/attic" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@attic"];	
  };
  fileSystems."/storage/git" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@git"];	
  };
  fileSystems."/storage/audio" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@audio"];	
  };
  fileSystems."/storage/backups" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@backups"];	
  };
  fileSystems."/storage/books" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@books"];	
  };
  fileSystems."/storage/games" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@games"];	
  };
  fileSystems."/storage/incoming" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@incoming"];	
  };
  fileSystems."/storage/misc" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@misc"];	
  };
  fileSystems."/storage/movies" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@movies"];	
  };
  fileSystems."/storage/software" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@software"];	
  };


   fileSystems."/home/liquuid/Downloads/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@downloads"];	
  };	
  fileSystems."/home/liquuid/Music/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@music"];	
  };	
  fileSystems."/home/liquuid/Steam/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@steam"];	
  };	
 
  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 12;
  # High-DPI console
  #console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hydra"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp27s0.useDHCP = true;
  networking.interfaces.wlp28s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "pt_BR.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
   };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     zeal 
     wget 
     xfce.xfce4-power-manager
     networkmanager_dmenu
     clementine
     transmission-gtk
     insomnia
     docker
     docker-compose
     vscode-with-extensions
     gimp
     inkscape
     krita
     lmms
     go
     vim 
     micro 
     xterm 
     mpv  
     ffmpeg
     x264
     x265
     vscode 
     git
     tig
     htop 
     kdenlive
     blender
     dstat 
     python3 
     arandr 
     arduino
     codeblocks
     firefox-bin 
     brave 
     audacity
     gcc
     krusader pcmanfm spaceFM nitrogen rofi dmenu sakura st fira-code fira-code-symbols fira-mono
     SDL2
     SDL2_image
     virtualbox
     vagrant
     yakuake
     okular
     gwenview
     p7zip
     ark
     obs-studio
     #steam

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true ;
# Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "br";
  #services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liquuid = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
