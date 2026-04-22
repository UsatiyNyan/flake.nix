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
  my-claude = pkgs.writeShellApplication {
    name = "my-claude";
    runtimeInputs = [pkgs.nodejs pkgs-unstable.claude-code];
    text = ''
      claude "$@"
    '';
  };
in {
  home = {
    packages = (with pkgs; [aider-chat]) ++ (with pkgs-unstable; [claude-code]) ++ [my-claude];
    file = {
      ".local/.gitignore".text = ''
        .aider*
      '';
    };
  };
}
