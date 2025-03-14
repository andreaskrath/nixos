{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "greeter";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "thegrubster";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-ceXilZxeakM/0OJUBsuDDgOnBQ5tuS4/95lTqHCVfI8=";
  };

  vendorHash = "sha256-+tEmXHlvG6R4NAXBoVbYpPe7hrF77BV5vfeFI0PaYxA=";
}
