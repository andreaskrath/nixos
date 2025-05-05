{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "greeter";

  # Remember to clear hashes upon version bumping
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "andreaskrath";
    repo = pname;
    rev = version;
    sha256 = "sha256-4pA5Xr/rCOVa0+S4DK+TlkI5+V+IWZ4WEQgOoD+U5GU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-9j/1S8gJK7UkpEneInIj0zW+Xj0rSeG4YjkZLnmOj7k=";
}
