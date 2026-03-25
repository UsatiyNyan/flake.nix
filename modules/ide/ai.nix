{
  pkgs,
  inputs,
  system,
  ...
}: let
  pkgs-unstable =
    import inputs.nixpkgs-unstable
    {
      inherit system;
      config.allowUnfree = true;
    };
in {
  home = {
    packages = (with pkgs; [aider-chat]) ++ (with pkgs-unstable; [claude-code]);
    file = {
      ".local/.gitignore".text = ''
        .aider*
      '';
    };
  };
}
