{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "greeter";

  # Remember to clear hashes upon version bumping
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "andreaskrath";
    repo = pname;
    rev = version;
    sha256 = "sha256-ZDorl+4u4Y4Hj4jsj5yWJ9y92B56LmZCMztZYEooQ7A=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-8d1tpKg+QnSTy9Kuf7Q6DCUWMDSIBJS87uEoMbvwrSY=";
}
