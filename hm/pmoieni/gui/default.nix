{
  lib,
  isNixOS,
  config,
  ...
}:
{
  imports = [ ] ++ lib.optionals isNixOS [ ./stylix.nix ];

  home.packages = lib.mkIf config.system.gui.enable ([ ]);
}
