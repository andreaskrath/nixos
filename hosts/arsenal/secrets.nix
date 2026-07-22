{
  age.secrets = {
    wg-private-key.file = ../../secrets/wg-arsenal-private.age;

    b2-password.file = ../../secrets/b2-password.age;

    b2-foundry-environment.file = ../../secrets/b2-foundry-environment.age;
    b2-foundry-bucket.file = ../../secrets/b2-foundry-bucket.age;

    vikunja-secret.file = ../../secrets/vikunja-secret.age;
    b2-vikunja-environment.file = ../../secrets/b2-vikunja-environment.age;
    b2-vikunja-bucket.file = ../../secrets/b2-vikunja-bucket.age;

    b2-actual-environment.file = ../../secrets/b2-actual-environment.age;
    b2-actual-bucket.file = ../../secrets/b2-actual-bucket.age;
  };
}
