{ pkgs, ... }:
{
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
      qt.enable = true;
    };
    cursor = {
      name = "Bibata-Original-Classic";
      package = pkgs.bibata-cursors;
      size = 12;
    };
  };
}
