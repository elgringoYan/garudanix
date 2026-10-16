# This is your home-manager configuration file
# Use this to configure your home environment.
# (On NixOS this is imported per user from nixos/configuration.nix
# via home-manager.users."<name>".)
{
  pkgs,
  inputs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    inputs.nixdatifier.homeManagerModules.default
  ];

  home = {
    username = "yan";
    homeDirectory = "/home/yan";
  };

  programs.git = {
    settings = {
      user = {
        name = "Yan";
        email = "ymcdonald@izayan.ca";
      };
    
      credential.helper = "!gh auth git-credential";
    };
  };

  programs.neovim = {
    enable=true;
    defaultEditor = true;

    initLua = ''
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      '';
  };

  programs.nixdatifier = {
    enable = true;
    autostart = true; # default: true, starts in tray at login
  };

  programs.yazi = {
    enable = true;

    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

  programs.qutebrowser = {
    enable = true;

    settings = {
      colors.webpage.darkmode.enabled = true;
      content.headers.accept_language =
        "fr-CA,fr;q=0.9,en-CA;q=0.8,en;q=0.7";
    };
  };

  services.ssh-agent.enable = true;

  #Historique des commandes shell
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    lazygit
    gh
    wl-clipboard
    ripgrep
    virt-viewer
    kdePackages.kcalc
    caprine
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.11";
}
