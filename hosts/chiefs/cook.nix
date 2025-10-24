{...}: {
  services.cook-cli = {
    enable = true;
    autoStart = true;
    basePath = "/var/recipes";
  };
}
