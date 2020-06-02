{ config, pkgs, lib, ... }:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../assets/layout.xkb} $out
  '';
in
{
  environment.systemPackages = with pkgs;
      [
      gnome3.adwaita-icon-theme
      gnomeExtensions.appindicator     
      gnome3.gnome-settings-daemon 
      gnome3.gnome-tweaks
      gthumb
      ];

  environment.shellAliases = {
    x = "sudo systemctl start display-manager.service";
    xr = "sudo systemctl restart display-manager.service";
  };

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    displayManager = {
      defaultSession = "gnome-xorg";
    };

    desktopManager.gnome3.enable = true;

  };
}
