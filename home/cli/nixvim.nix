# NixVim docs:    https://nix-community.github.io/nixvim/
# Neovim Options: https://nix-community.github.io/nixvim/NeovimOptions/index.html

{ pkgs, lib }: {
  enable        = true;
  defaultEditor = true;
  vimAlias      = true;
  viAlias       = true;

  # TODO colorscheme & syntax highlighting
  colorschemes.gruvbox = {
    enable = true;
#    flavor = "duskfox";
  };

  plugins = {
    lspkind.enable = true;
    lsp-format.enable = true;
    lsp-status.enable = true;
    lsp.enable = true;

    lualine.enable = true;

    markdown-preview = {
      enable = true;
      #settings.auto_close = 0;
    };

    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
  };

  lsp = {
    # TODO customise what LSPs are installed .. just default from ithinuel currently
    inlayHints.enable = true;
    servers = {
      asm_lsp.enable = true;
      bashls.enable = true;
      bitbake_language_server.enable = pkgs.stdenv.isLinux;
      clangd.enable = true;
      cmake.enable = true;
      dockerls.enable = true;
      #gitlab_ci_ls.enable = true; # TODO: Enable when available
      jsonls.enable = true;
      just.enable = true;
      lua_ls.enable = true;
      pyright.enable = true;
      ruff.enable = true;
      # TODO: the default config doesn’t work great quite yet
      # see https://github.com/nix-community/nixvim/issues/3296
      #statix.enable = true;
      yamlls.enable = true;

      rust_analyzer = {
        enable = true;
      };
      nixd = {
        enable = true;
        settings.formatting.command = [ "nixpkgs-fmt" ];
      };
    };
  };

  # extraPlugings = TODO if necessary

  opts = {
    # TODO look through the docs and comment about what each one of these does!
    termguicolors = true;

    encoding = "utf-8";
    cursorline = true;

    wrap = false;
    sidescroll = 8;
    showbreak = "↪";

    viewoptions = [ "folds" "cursor" ];

    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    smartindent = true;

    foldmethod = "syntax";
    foldcolumn = "1";
    foldlevel = 99;

    ruler = true;
    number = true;

    smartcase = true;
    incsearch = true;
    hlsearch = true;

    mouse = "a";

    list = true;
    listchars = "tab:»\\ ,trail:\\u2217,nbsp:⎵,precedes:<,extends:>"; #   TODO experiment around with this one, and see what works and what doesn't
  };

  #globals.mapleader = " ";
  #keymaps = [
    # TODO!
    # idea: g -> grep -r in directory
    # idea: fuzzy finder or similarly search for similar looking things (not a regex etc..)
    # idea: make current file executable, or just chmod current file and specify +x or -r etc.. with examples given.
    # idea: home-manager switch command without having to leave nvim
  #];
}
