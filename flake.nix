# Garuda Nix configuration.
# Rebuild with `nixos-rebuild switch --flake /etc/nixos#GarudaNix`.
{
  description = "Garuda NixOS configuration";
  nixConfig = {
    extra-substituters = [ "https://nyx-cache.chaotic.cx/" ];
    extra-trusted-public-keys = [
      "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
    ];
  };

  inputs = {
    # This input brings Nixpkgs, home-manager, Chaotic-Nyx via garuda.lib.garudaSystem.
    # There is no need to specify them separately unless you have a reason to do so.
    # garuda.url = "gitlab:garuda-linux/garuda-nix-subsystem/stable";
    garuda.url = "git+https://gitlab.com/garuda-linux/garuda-nix-subsystem.git?ref=stable";
    nixdatifier.url = "github:Muddyblack/kde-nixdatifier";
  };

  outputs =
    {
      garuda,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Reusable nixos modules you might want to export
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#GarudaNix'
      nixosConfigurations."Salon" = garuda.lib.garudaSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };
}
