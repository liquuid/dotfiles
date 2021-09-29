# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#	networking.wireless.networks."liquuidN" = { psk = '3g3g3g3g' } ;
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0f1.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
   };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["modesetting"];
  services.xserver.useGlamor = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "br";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {
      enableHybridCodec = true; 
    };
  };  
  hardware.opengl = {
       enable = true;
       extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
  	];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liquuid = {
     shell = pkgs.zsh;
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget vim micro dstat tree gotop compsize
     firefox brave
     vscode-fhs git tig dbeaver insomnia go rustc zeal jetbrains.pycharm-professional 
     xterm xorg.xinit alacritty xclip yakuake
     docker docker-compose
     nodejs-14_x yarn deno
     #python39Full python39Packages.ipython
     strawberry
     gwenview okular 
     zsnes sdlmame 
     obs-studio gimp inkscape blender kdenlive akira-unstable sakura ffmpeg-full youtube-dl
     syncthingtray syncthing transmission-qt
     adoptopenjdk-bin
     unzip p7zip
     refind
     neofetch
     mpv
     meslo-lg meslo-lgs-nf
     killall
     fortune
     fvwm xfce.thunar pcmanfm
     bzip2 celt fontconfig freetype frei0r fribidi game-music-emu gnutls gsm
     libjack2 ladspaH lame libass libbluray libbs2b libcaca libdc1394 libmodplug
     libogg libopus libssh libtheora libvdpau libvorbis libvpx libwebp
     lzma openal libpulseaudio rtmpdump opencore-amr makeWrapper
     samba #kamoso 
     SDL2 python39Packages.future python38Packages.future renpy 
     soxr mesa speex vid-stab wavpack x264 x265 xavs xvidcore zeromq4 zlib libaom libv4l openssl
     gcc cmake gnumake nasm yasm pkg-config binutils
     adapta-kde-theme arc-kde-theme kdeplasma-addons latte-dock plasma-browser-integration libsForQt5.kde2-decoration 
     adwaita-qt htop gotop libreoffice weston
     terminator rofi nitrogen dmenu flameshot nnn ranger picom networkmanagerapplet kde-gtk-config krusader
   ];
  programs.sway = {
	  enable = true;
	  wrapperFeatures.gtk = true; # so that gtk works properly
		  extraPackages = with pkgs; [
		  swaylock
			  swayidle
			  wl-clipboard
			  mako # notification daemon
			  alacritty # Alacritty is the default terminal in the config
			  dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
		  ];
  };
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;
  programs.adb.enable = true;
  programs.steam.enable = true;
  programs.zsh.ohMyZsh = {
	  enable = true;
	  plugins = [ "git" "python" "man" "adbusers" ];
	  theme = "agnoster";
  };  
  services.xserver.windowManager.awesome = {
	enable = true;
	luaModules = with pkgs.luaPackages; [
		luarocks
		luadbi-mysql
	];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

