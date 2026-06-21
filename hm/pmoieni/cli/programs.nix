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
    zoxide.enable = true;
  };
}
