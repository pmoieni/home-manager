{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    neovim
    fish
    tokei
    gh
    ripgrep
    subversion
    stow
  ];
}
