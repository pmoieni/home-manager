{
  lib,
  config,
  pkgs,
  isNixOS,
  ...
}:
let
  xray-git = pkgs.buildGo126Module (finalAttrs: {
    pname = "xray";
    version = "26.7.28";

    src = pkgs.fetchFromGitHub {
      owner = "XTLS";
      repo = "Xray-core";
      rev = "v${finalAttrs.version}";
      hash = "sha256-6qW8Un6VC0kFPyrFMQxruWz18flyeZyFs0A7avoi56I=";
    };

    vendorHash = "sha256-n1/bxtOadcdnXg/opvv7gU2Dr/vbt5kGfdZCyk9CY8w=";

    ldflags = [
      "-s"
      "-w"
    ];
    subPackages = [ "main" ];

    installPhase = ''
      runHook preInstall
      install -Dm555 "$GOPATH"/bin/main $out/bin/xray
      runHook postInstall
    '';

    meta = {
      description = "Platform for building proxies to bypass network restrictions. A replacement for v2ray-core, with XTLS support and fully compatible configuration";
      mainProgram = "xray";
      homepage = "https://github.com/XTLS/Xray-core";
      license = lib.licenses.mpl20;
      maintainers = with lib.maintainers; [ iopq ];
    };
  });
in
{
  imports = [ ] ++ lib.optionals isNixOS [ ./stylix.nix ];

  home.packages = lib.mkIf config.system.gui.enable ([ ]);

  # xdg.dataFile = {
    # v2rayn
  #   "v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
  #   "v2rayN/bin/xray/xray".source = "${xray-git}/bin/xray";
  #   "v2rayN/bin/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
  #   "v2rayN/bin/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
  # };
}
