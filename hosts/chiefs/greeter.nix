{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "greeter";
  version = "0.3.2";
  src = fetchFromGitHub {
    owner = "thegrubster";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-QO2Ukte7hKMwPHQC4BZMPhkLsql2Q+pAigJ/i0dg7zA=";
  };

  vendorHash = "sha256-+tEmXHlvG6R4NAXBoVbYpPe7hrF77BV5vfeFI0PaYxA=";
}
