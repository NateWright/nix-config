```bash
sudo cp * /etc/nixos/
sudo nixos-rebuild switch
```

trace: warning: The option `services.openssh.passwordAuthentication' defined in `/etc/nixos/configuration.nix' has been renamed to `services.openssh.settings.PasswordAuthentication'.
trace: warning: The option `services.openssh.kbdInteractiveAuthentication' defined in `/etc/nixos/configuration.nix' has been renamed to `services.openssh.settings.KbdInteractiveAuthentication'.