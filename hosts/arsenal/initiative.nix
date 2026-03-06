{
  npmHooks,
  fetchNpmDeps,
  nodejs,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
  stdenv,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "initiative";

  # Remember to clear hashes upon version bumping
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "andreaskrath";
    repo = pname;
    rev = version;
    sha256 = "sha256-dofcvP4hy+H1wgCbKN1OZ58xKx7d0CI8VNdfGTuUrSs=";
  };

  cargoHash = "sha256-CEmRwq1/1+lhsidto4aQk6+DZiQ7VBhAaCEkozkiu8M=";

  nativeBuildInputs = [
    pkg-config
    openssl
  ];

  buildInputs = [
    openssl
  ];

  view = stdenv.mkDerivation rec {
    pname = "view";
    inherit version src;
    sourceRoot = "${src.name}/view";

    npmDeps = fetchNpmDeps {
      name = "${pname}-${version}-npm-deps";
      src = "${src}/view";
      hash = "sha256-KkR+O/uFqcFNytchHHI88nJtaJrWsVNmRe7suy7BwXQ=";
    };

    nativeBuildInputs = [
      nodejs
      npmHooks.npmConfigHook
      npmHooks.npmBuildHook
    ];

    npmBuildScript = "build";

    installPhase = ''
      mkdir $out
      cp -r dist/* $out/
    '';
  };

  postPatch = ''
    cp -r ${view} view/dist
  '';
}
