# NixOS setup

## cmds

```sh
sudo nixos-install --flake .#<host-name> # if running for the first time
sudo nixos-rebuild switch --flake .#<host-name> # else rebuild

home-manager switch --flake .#<user>
```
