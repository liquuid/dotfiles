{ config, pkgs, lib, ... }:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../assets/layout.xkb} $out
  '';
in
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        polybar
        xcape
        nitrogen
        networkmanager_dmenu
        lxqt.lxqt-policykit
        rofi
        libnotify
        dunst
        xfce.xfce4-power-manager
        pulsemixer
        krusader
        pcmanfm
        dmenu
        sakura
        st
        xfce.xfce4-settings # xfce4-mime-settings
      ];

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    displayManager = {
      defaultSession = "awesome";
      sessionCommands = lib.mkDefault ''
        # ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
        (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
        sh ~/.fehbg
        xsetroot -cursor_name left_ptr
        
        lxqt-policykit-agent &
        xxkb &
        xcape -e 'Super_R=Super_R|X'
        sh ~/.config/conky/launch.sh
      '';
    };

    windowManager = {
      awesome.enable = true;

    };
  };
}
