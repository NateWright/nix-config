{ ... }:
{
  services.borgbackup.repos = {
    nwright-nixos-pc = {
      authorizedKeys = [
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCrXwrARo7f04l6ZASsuaUCEJLRmENkSnETQizQiV5F"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINk9Wr+xV4oT3cY56ImHqr4haZWI/NM3nfE5B64YnLpa nwright@DESKTOP-2QJDFJL"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0zSv6qKh5VA5zSj/qqcbLwuzsX0XMKRk8CdKbYvVhyabzIC2uSUEeFN1YX64AIvDaqqSIe8cwJrZmLk2QchEi6PfwzREjBl3rTp4yT/RZYBN+HQUd1YIINRRiCavDo+tx4Zu72TJXzgZjpdUWnYq93ChNVuLMaYfNVGDBIiTzjNVJjWoA3h80vPiaMql5WUhXeOwOPrSDL0h/7H+2FZ0VVra0Qj7K0gR1IA5zSa2zZ7fxVU3dayLEUut3Gb8zdrkS4m6K2ItXfKD3UT8wTbYwfaGzgv2r3wnru+3nh+Gu9Pu0sde4Q90fenBjBnSAR5sPNPmtUFRx4J6I6SZROZsRchnJbU5rQp8QLHhsw+xJMteL0aXTLVmPHuM+cHmoYlOXY9O7ONu/TYMw17WwlNWEl7vl62TzkFZ5a3WfUA219LwYqbeT2y5ejoPY1EE9vqRTZHPuc5deEcLq1mNhXPkxAVi4FECCrH60xTg59mEvgGS/97d2AF/LYSLF9s0WiL8= nwright@nwright-surface"
      ];
      path = "/vault/backups/backup_nwright_nwright-nixos-pc";
    };
  };
}
