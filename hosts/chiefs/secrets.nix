{
  age.secrets = {
    cloudflare-api-key = {
      file = ../../secrets/cloudflare-api-key.age;
      owner = "acme";
      group = "acme";
    };

    wg-private-key.file = ../../secrets/wg-chiefs-private.age;
  };
}
