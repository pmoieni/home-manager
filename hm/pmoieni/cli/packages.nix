{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    neovim
    tree-sitter
    fish
    tokei
    gh
    ripgrep
    subversion
    stow
  ];
}
