{ inputs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
    ./options.nix
    ./cli
    ./gui
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

  programs.home-manager.enable = true;
}
