{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "greeter";
  version = "0.3.1";
  src = fetchFromGitHub {
    owner = "thegrubster";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-MLseNtWTZRgzmo2XdY2EQ10k5vb6dkODxGPXeBuD1pw=";
  };

  vendorHash = "sha256-+tEmXHlvG6R4NAXBoVbYpPe7hrF77BV5vfeFI0PaYxA=";
}
