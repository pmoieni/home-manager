{ config, inputs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
    ./options.nix
    ./cli.nix
    ./gui.nix
  ];

  home = {
    username = "pmoieni";
    homeDirectory = "/home/pmoieni";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
    };

    stateVersion = "25.05";
  };

  home.file = {
    ".config/alacritty".source = ~/home-manager/config/alacritty;
    ".config/nvim-dev".source = ~/home-manager/config/nvim-dev;
    ".config/nvim".source = ~/home-manager/config/nvim;
    ".config/zed".source = ~/home-manager/config/zed;
    ".config/fish".source = ~/home-manager/config/fish;
    ".config/niri".source = ~/home-manager/config/niri;
    ".config/noctalia".source = ~/home-manager/config/noctalia;
  };

  programs.home-manager.enable = true;
}
