{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "pmoieni";
        user.email = "62774242+pmoieni@users.noreply.github.com";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    # so home-manager can modify the rc files
    bash.enable = true;
    fish.enable = true;
    zoxide.enable = true;
  };
}
