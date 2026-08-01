{
  lib,
  config,
  pkgs,
  isNixOS,
  fetchFromGitHub,
  symlinkJoin,
  buildGo126Module,
  makeWrapper,
  nix-update-script,
  v2ray-rules-dat,
  assets ? [
    v2ray-rules-dat
  ],
  ...
}:
let
  xray-git = buildGo126Module (finalAttrs: {
    pname = "xray";
    version = "26.7.28";

    src = fetchFromGitHub {
      owner = "XTLS";
      repo = "Xray-core";
      rev = "v${finalAttrs.version}";
      hash = pkgs.lib.fakeHash;
    };

    vendorHash = pkgs.lib.fakeHash;

    nativeBuildInputs = [ makeWrapper ];

    doCheck = false;

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

    assetsDrv = symlinkJoin {
      name = "v2ray-assets";
      paths = assets;
    };

    postFixup = ''
      wrapProgram $out/bin/xray \
        --set-default V2RAY_LOCATION_ASSET $assetsDrv/share/v2ray \
        --set-default XRAY_LOCATION_ASSET $assetsDrv/share/v2ray
    '';

    passthru = {
      updateScript = nix-update-script { };
    };

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

  xdg.dataFile = {
    # v2rayn
    "v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
    "v2rayN/bin/xray/xray".source = "${xray-git}/bin/xray";
    "v2rayN/bin/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
    "v2rayN/bin/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
  };
}
