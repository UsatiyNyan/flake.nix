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
  my-opencode = pkgs.writeShellApplication {
    name = "my-opencode";
    runtimeInputs = [pkgs.nodejs pkgs-unstable.opencode];
    text = ''
      opencode "$@"
    '';
  };
in {
  home = {
    packages =
      (with pkgs-unstable; [claude-code opencode]) #
      ++ [my-claude my-opencode];
    file = {
      ".local/.gitignore".text = ''
      '';
      ".config/opencode/skills/".source = ./skills;
    };
  };
}
