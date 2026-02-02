{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    neovim
    tokei
    gh
    ripgrep
    subversion
    stow
  ];
}
