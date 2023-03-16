{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      extraPackages = [ ];
      plugins = with pkgs.vimPlugins; [ ];
    };
  };

  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
  home.file.".config/nvim/UltiSnips".source = ./UltiSnips;
}
