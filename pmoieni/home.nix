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
    ".config/alacritty".source = ~/.dots/config/alacritty;
    ".config/nvim-dev".source = ~/.dots/config/nvim-dev;
    ".config/nvim".source = ~/.dots/config/nvim;
    ".config/zed".source = ~/.dots/config/zed;
    ".config/fish".source = ~/.dots/config/fish;
    ".config/niri".source = ~/.dots/config/niri;
    ".config/noctalia".source = ~/.dots/config/noctalia;
  };

  programs.home-manager.enable = true;
}
