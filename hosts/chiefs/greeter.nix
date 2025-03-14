{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "greeter";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "thegrubster";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-+wRZbmUe7JkRbpBlXw6Fqe73Z+AsP6QkHEmtQ8BRNGg=";
  };

  vendorHash = "sha256-+tEmXHlvG6R4NAXBoVbYpPe7hrF77BV5vfeFI0PaYxA=";
}
