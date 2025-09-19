{
  me = {
    username = "niksingh710";
    fullname = "Nikhil Singh";
    email = "nik.singh710@gmail.com";
    sshPublicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
    ];
  };
  virt = {
    username = "virt";
    fullname = "Virtual Machine User";
    email = "virt@localhost";
    sshPublicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
    ];
    # TODO: Use the hashed password instead of plain text
    password = "virt";
  };
}
