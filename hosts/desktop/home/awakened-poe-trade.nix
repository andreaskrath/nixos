{ lib, fetchurl, appimageTools, ... }:
let
  pname = "awakened-poe-trade";
  version = "3.23.10003";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v${version}/Awakened-PoE-Trade-${version}.AppImage";
    sha256 = "sha256-ahHObVKmbLhuG/ByegoPWxGS95TKZoJxu43UG9rZy34=";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/awakened-poe-trade.desktop $out/share/applications/${pname}.desktop

    substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
  '';

  meta = with lib; {
    description = "Path of Exile trading app for price checking.";
    homepage = "https://github.com/SnosMe/awakened-poe-trade";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
