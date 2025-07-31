# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
  let
    pkgs2 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz") {};
  in 


{
 imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixosModules.default
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" "ntfs" ];
  boot.zfs.devNodes = "/dev/disk/by-label/images";
  #boot.zfs.extraPools = [ "images" ];

    # Configure kernel options to make sure IOMMU & KVM support is on.
  boot.kernelModules = [ "xpad" "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "dm-cache" ];
  boot.kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" "vfio-pci.ids=10de:2487,10de:228b" ];
  boot.extraModprobeConfig = ''
    options vfio-pci ids=10de:2487,10de:228b
    softdep nvidia pre: vfio-pci 
    options bluetooth disable_ertm=1 
  '';
  #boot.initrd.preLVMCommands = "lvchange -ay data/srv";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-34.5.8"];

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "hydra";
  networking.hostId= "4cc2f4d7";
  networking.extraHosts =
    ''
      #45.7.232.101 armvin-odoo-hml.kmee.dev.br
      #45.236.241.175 gmatacadista.com.br king.maximaatacadista.com.br
      #45.7.232.108 erplivre.com.br
    '';


  networking.useDHCP = false;
  networking.bridges = {
    "bridge0" = {
      interfaces = [ "enp42s0" ];
    };
  };
  networking.interfaces.bridge0.ipv4.addresses = [ {
    address = "192.168.0.100";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = ["192.168.0.110" "8.8.8.8"];
  
  #services.resolved = {
  #  enable = true;
  #    dnssec = "false";
  #    domains = [ "~." ];
  #    fallbackDns = [ "192.168.0.110" "8.8.8.8" ];
  #    dnsovertls = "false";
  #  }; 

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "pt_BR.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "br";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
  services.open-webui = {
    enable = true;
  };
  
  services.flatpak.enable=true; 
  #services.cockpit.enable=true; 

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.wacom.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the Plasma 5 Desktop Environment.
  services.displayManager = { 
  	sddm.enable = true;
  	defaultSession = "plasma";
  };
  #services.displayManager.gdm.enable=true;
  services.desktopManager.plasma6.enable = true;
  #services.desktopManager..enable = true;
  services.xserver.windowManager.hypr.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.desktopManager.lomiri.enable = true;
#  systemd.tmpfiles.rules = [
#    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
#  ];

#  hardware.opengl.extraPackages = with pkgs; [
#    rocm-opencl-icd
#    rocm-opencl-runtime
#    clinfo
#  ];

   #hardware.opengl.driSupport = true;
   # For 32 bit applications
   #hardware.opengl.driSupport32Bit = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "br";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
  	enable = true;
	nssmdns4 = true;
	openFirewall = true;
  };

  # Enable sound.
  #sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  #hardware.opengl.enable = true;
  hardware.graphics.enable = true;
  services.blueman.enable = false;
  #services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.wrappers."mount.nfs" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.nfs-utils.out}/bin/mount.nfs";
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


hardware.bluetooth.settings = {
  General = {
    Enable = "Source,Sink,Media,Socket";
    Experimental = true;
  };
};

  #hardware.nvidia = {

    # Modesetting is required.
  #  modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #  powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #  powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #  open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
  #  nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
#  }; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liquuid = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "dialout" "wheel" "libvirtd" "scanner" "lp" "podman" ];
    packages = with pkgs; [
      tree
     ];
  };
  users.users.gu = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "dialout" "wheel" "podman" "libvirtd" "scanner" "lp"];
    packages = with pkgs; [
      tree
     ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     pkgs2.yuzu
     pkgs2.citra
  # editors
     vim micro
  # tools
  zoxide killall lfs wget unzip p7zip dool tree gotop iotop htop dig nmap openvpn jetbrains-mono file nixos-option usbutils unrar appimage-run kdePackages.yakuake yt-dlp media-downloader nfs-utils xorg.xhost libxfs xfsprogs filezilla zfs nnn fastfetch kdePackages.skanlite xsane gocr shntool flac opusTools   
  # libxfs
  # xfsprogs
  # wireshark
  # alex
  # unetbootin 
  # easyeffects
  # wkhtmltopdf
  # compsize
  # ksane  #nomachine-client balena-cli ncftp freemind 
  # browsers
    #google-chrome 
    firefox brave  
    #opera 
    #librewolf 
# dev tools
    spice spice-gtk spice-protocol win-virtio win-spice virt-viewer virt-manager virtiofsd qemu arduino godot_4 vscode rstudio git tig dbeaver-bin insomnia go ansible logisim-evolution gnumake  gnumake42 cmake android-studio  #cope zeal vagrant
 
  # x11 apps
     alacritty kitty waybar hyprpaper xterm xorg.xinit xclip #alacritty flameshot nitrogen terminator gdk-pixbuf
  # containers
  #   docker docker-compose
     podman-compose podman-desktop
  # IAC 
     terraform
     terraform-providers.libvirt
     cdrtools
     libxslt
  # nodejs
  #  nodejs yarn deno
  # python
     python3Full python3Packages.pip python3Packages.ipython #devenv  #ython39Packages.pandas 
  # music
     strawberry feishin termsonic lmms libsForQt5.phonon libsForQt5.phonon-backend-gstreamer # lollypop hydrogen kid3 famistudio amarok
  # games 
  # dolphin-emu abuse zsnes2 prismlauncher # steam citra yuzu
    prismlauncher
    moonlight-qt
  # video tools
     obs-studio kdePackages.kdenlive mpv vlc kdePackages.ffmpegthumbs handbrake ffmpeg-full mediainfo glaxnimate duf lfs #natron plex
  # graphical tools
    gimp3 inkscape krita blender-hip # pixelorama diylc
  # office 
    pdf2djvu djvulibre djvu2pdf djview4 #wpsoffice #joplin-desktop # joplin zeal
  # gnome stuff
  #   gnome3.adwaita-icon-theme
    # gnome3.gnome-tweaks
  #   gnomeExtensions.appindicator
   # dracula-theme
  #   gnome.gedit
    # gthumb
     #gnomeExtensions.syncthing-indicator
  # plasma stuff
    kdePackages.qtwebengine
    kdePackages.plasma-browser-integration
    kdePackages.kaccounts-providers
    kdePackages.kaccounts-integration
    kdePackages.qtstyleplugin-kvantum
    themechanger
    ayu-theme-gtk
    catppuccin-kvantum
    kvmarwaita
    isoimagewriter
    ktimetracker
    #akregator
    #kmix
    #calligra
    libreoffice
    #neochat
    index-fm
    wineWow64Packages.full
     
    gruvbox-kvantum
  # digikam
    exiftool
    kdePackages.filelight
    filezilla
    vdhcoapp
    #kate
    kdePackages.kcalc
    #kaddressbook
    #ktorrent
    #akonadi
    #kmail
    #korganizer
    #kontact
    #tokodon
    libsForQt5.qt5.qtimageformats
    libsForQt5.kimageformats
    qt6.qtimageformats
    #libsForQt5.kdepim-runtime
    #kaddressbook
    kdePackages.kio-gdrive
    kdePackages.kio-zeroconf
    kdePackages.kio-extras
    kdePackages.signond 
    libsForQt5.qoauth
    sshfs
    #foliate
  # eng
    #stlink stlink-gui 
    #fritzing logisim-evolution freecad openscad prusa-slicer sigrok-cli pulseview # qucs cura
  # CAD
    openscad freecad
  # comunication
    remmina strongswan networkmanager_strongswan wpa_supplicant wpa_supplicant_gui wirelesstools dhcpcd dhcping #thunderbird whatsapp-for-linux discord slack tdesktop
  # p2p
     nextcloud-client soulseekqt transmission_3-qt #barrier # transmission-qt 
  # misc
     steam-run
     heroic
     jq
     yq
     kdePackages.discover
     smartmontools
     calibre
     pandoc
     tetex
     lm_sensors
     pcsctools
     pcsclite
     #scmccid
     #adoptopenjdk-bin
     #temurin-bin
     libwebp
     imagemagick
     distrobox
     sshpass
     #heroku
     appflowy
     #dduper
     ghostscript
     woeusb
     jdk
     jdk21
  # fonts 
    dejavu_fonts open-sans clearlyU cm_unicode corefonts powerline-fonts ankacoder fira-code fira-code-symbols fira-mono font-manager     
    #rescuetime
    furtherance
    #jetbrains.goland
    #jetbrains.pycharm-professional
    jetbrains.pycharm-community-bin
    #jetbrains.idea-ultimate
    jetbrains.idea-community-bin
    #kdevelop
    #qtcreator
    #jetbrains.clion
    #jetbrains.webstorm
    #usb-reset
    devpod
    devpod-desktop

  ];
    #nixpkgs.config.packageOverrides = pkgs: { opera = pkgs.opera.override { proprietaryCodecs = true; };};
    programs.dconf.enable = true;
    programs.java.enable = true;
    programs.kdeconnect.enable = true;
    #programs.virt-manager.enable = true;
    #virtualisation.docker.enable = true;
    virtualisation.podman =  {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; 
    };
    
    
    #virtualisation.virtualbox.host.enable = true;
    #virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation = {
          libvirtd = {
	    enable = true;
	    onShutdown = "suspend";
	    onBoot = "ignore";
	    qemu = {
              swtpm.enable = true; 
              ovmf.enable = true;
              ovmf.packages = [ pkgs.OVMFFull.fd ];
            };
          };
      spiceUSBRedirection.enable = true;
    };
    #services.cron = {
    #	enable = true;
    #	systemCronJobs = [
    #		"*/5 * * * *  liquuid docker exec -u www-data nextcloud-app-1 php /var/www/html/cron.php > /tmp/nextcloud.log"
    #	];
    #};
    #home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    # users = {
    #   "liquuid" = import ./home.nix;
    # };
    #;
    
    services.spice-vdagentd.enable = true;
    #virtualisation.libvirtd.enable = true;
    environment.etc = {
      "ovmf/edk2-x86_64-secure-code.fd" = {
         source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
      };
  
      "ovmf/edk2-i386-vars.fd" = {
         source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
      };
    };

  
    programs.adb.enable = true;
    programs.zsh.enable = true;
    programs.zsh.ohMyZsh = {
      enable = true;
      #plugins = [ "git" "python" "man" "adbusers" ];
      plugins = [ "git" "python" "man" ];
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
  networking.firewall.allowedTCPPorts = [ 3300 3080 5678 8080 24800 35045 9002 ];
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

