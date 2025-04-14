{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "greeter";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "andreaskrath";
    repo = pname;
    rev = version;
    sha256 = "sha256-VeQlkXSIehgZdt0svhaCi2Z4uUe+gp6NBNW6K9jIljA=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-lK2Z6bjnVymYqWmR2t5AANsrnowWtK94XRmv90xFzu4=";
}
