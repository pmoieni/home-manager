{
  # This NixOS module bridges the existing home-manager configuration.
  home-manager.users.pmoieni = {
    imports = [ ./home.nix ];
  };
}
