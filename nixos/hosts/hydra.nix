{ config,lib, pkgs, ... }:
{

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
  
  imports =
    [ 
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/sys/debug.nix
      ../modules/sys/aliases.nix
      ../modules/sys/scripts.nix
      ../modules/sys/tty.nix

      ../modules/boot/efi.nix
      ../modules/boot/multiboot.nix

      ../modules/services/common.nix
      ../modules/services/x.nix
      
      ../modules/x/gnome.nix
      ../modules/x/fonts.nix

      ../modules/packages/x-common.nix
      ../modules/packages/x-extra.nix

      ../modules/packages/absolutely-proprietary.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix

      ../modules/packages/games.nix
      ../modules/hardware/sound.nix
      ../modules/hardware/ssd.nix

      ../modules/net/firewall-desktop.nix
      ../users/liquuid.nix

    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6e5b74c3-b8af-411b-b5b5-40fb8f95835f";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd" ];
  };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6e5b74c3-b8af-411b-b5b5-40fb8f95835f";
      fsType = "btrfs";
      options = [ "subvol=@home" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd" ];
    };
  fileSystems."/boot/" = 
  { device = "/dev/sdb1";
     fsType = "vfat";
  };
  fileSystems."/storage/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@storage" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/attic" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@attic" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/git" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@git" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/audio" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@audio" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/backups" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@backups" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/books" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@books" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/games" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@games" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/incoming" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@incoming" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/misc" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@misc" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/movies" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@movies" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };
  fileSystems."/storage/software" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@software" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };


   fileSystems."/home/liquuid/Downloads/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@downloads" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };	
  fileSystems."/home/liquuid/Music/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@music" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };	
  fileSystems."/home/liquuid/Steam/" = 
  { device = "/dev/sda1";
    fsType = "btrfs";
    options = [ "subvol=@steam" "defaults" "noatime" "space_cache" "autodefrag" "discard" "compress=zstd"];	
  };	
  fileSystems."/home/liquuid/.var/app/com.valvesoftware.Steam" = 
  { device = "/home/liquuid/Steam/com.valvesoftware.Steam";
    options = ["bind"];	
  };	
 

  swapDevices = [ ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.docker.enable = true;
  users.extraGroups.vboxusers.members = [ "liquuid" ];

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
     #keyMap = "br-abnt2";
   };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim
     xterm

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
  services.nfs.server.enable = true;
  nixpkgs.config.allowUnfree = true;
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';
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
  
  #services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liquuid = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };



}
