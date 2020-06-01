{ config, pkgs, ... }:
# let
#   user = "ksevelyar";
#   userName = config.users.users."${user}".name;
#   home = config.users.users."${user}".home;
#   fontSize = 14;
#
#   startupBanner = pkgs.fetchurl {
#     url = "https://github.com/NixOS/nixos-homepage/raw/master/logo/nix-wiki.png";
#     sha256 = "1hrz7wr7i0b2bips60ygacbkmdzv466lsbxi22hycg42kv4m0173";
#   };
# in
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # systemd.services =
  #   let
  #     clone =
  #       repository: folder: branch:
  #         {
  #           enable = true;
  #           wantedBy = [ "multi-user.target" ];
  #           description = "clone ${repository} to ${folder}";
  #           serviceConfig.User = userName;
  #           unitConfig.ConditionPathExists = "!${folder}";
  #           script = ''
  #             ${pkgs.git}/bin/git clone ${repository} --branch ${branch} ${folder}
  #           '';
  #         };
  #   in
  #     {
  #       emacs-pull = clone "https://github.com/syl20bnr/spacemacs" "${home}/.emacs.d" "master";
  #     };

  users.defaultUserShell = pkgs.zsh;
  i18n.defaultLocale = "pt_BR.UTF-8";

  time.timeZone = "America/Sao_Paulo";
  location.latitude = 23.32;
  location.longitude = 46.38;

  environment = {
    variables = {
      EDITOR = "vim";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
  };
}
