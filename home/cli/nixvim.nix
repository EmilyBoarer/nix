# NixVim docs:    https://nix-community.github.io/nixvim/
# Neovim Options: https://nix-community.github.io/nixvim/NeovimOptions/index.html

{ pkgs, ... }: {
  enable        = true;
  defaultEditor = true;
  vimAlias      = true;
  viAlias       = true;

  # TODO colorscheme & syntax highlighting
  colorschemes.gruvbox = {
    enable = true;
  };

  plugins = {
    # List of Plugins Available: https://github.com/nix-community/nixvim/tree/main/plugins/by-name

    # Language Server Protocol bits:
    lspkind.enable = true;
    lsp-format.enable = true;
    lsp-status.enable = true;
    lsp.enable = true;

    # Prettify the status bar at the bottom:
    lualine.enable = true;

    # Set background text etc..
    dashboard = {
      enable = true;
      settings = {
        config = {
          header = [
            " █████   █████ █████ ██████   ██████ █████ █████       █████ █████"
            "░░███   ░░███ ░░███ ░░██████ ██████ ░░███ ░░███       ░░███ ░░███ "
            " ░███    ░███  ░███  ░███░█████░███  ░███  ░███        ░░███ ███  "
            " ░███    ░███  ░███  ░███░░███ ░███  ░███  ░███         ░░█████   "
            " ░░███   ███   ░███  ░███ ░░░  ░███  ░███  ░███          ░░███    "
            "  ░░░█████░    ░███  ░███      ░███  ░███  ░███      █    ░███    "
            "    ░░███      █████ █████     █████ █████ ███████████    █████   "
            "     ░░░      ░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░░░░░░░    ░░░░░    "
            ""
          ];
          shortcut = [{ desc = "leader = <space>"; }];
          disable_move = true;
          packages.enable = false;
          project.limit = 5;
          mru.limit = 15;
          footer = [ "" "nixvim (neovim) - Configured with ❤️ in Cambridge, UK" ];
        };
      };
    };

    # TODO investigate `diffview` https://github.com/nix-community/nixvim/blob/main/plugins/by-name/diffview/default.nix
    # TODO look into git-worktree and other git related plugins

    # TODO: treesitter - duplicate of LSP or a good addition?

    # TODO try this out:
    markdown-preview = {
      enable = true;
      #settings.auto_close = 0;
    };

    # TODO what do these do:
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
    # https://neovim.io/doc/user/options.html
    # TODO look through the docs and comment about what each one of these does!
    termguicolors = true;

    encoding = "utf-8";
    cursorline = true;

    wrap = true;
    sidescroll = 8;
    showbreak = "↳"; ## TODO future special characters, noted here for later: ↯ ❰❱❲❳⦃⦄⟬⟭〈〉⦗⦘⸨⸩⸙〘〙〈〉《》𑗋

    viewoptions = [ "folds" "cursor" ];

    # Defines the column multiple used to display the Horizontal Tab character
    tabstop = 8; # TODO only want 2 for nix files, want 8 for most OSS applications!
    # Number of columns that make up one level of (auto)indentation
    shiftwidth = 2;
    # In Insert mode: Use the appropriate number of spaces to insert a <Tab>
    expandtab = true;
    # Do smart autoindenting when starting a new line
    smartindent = true;
    # TODO stop comments from losing their smart-indent!

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
    listchars = "tab:⇆ ,trail:؟,nbsp:⎵,precedes:<,extends:>";
  };

  globals.mapleader = " ";
  keymaps = [
    { key = "<leader>t"; options.desc = "test action to do something"; action = ":echo \"Hello, World!\""; }
    #{ key = "<leader>g"; options.desc = "`grep -r` in directory"; action = "" }
    # idea: g -> grep -r in directory
    # idea: fuzzy finder or similarly search for similar looking things (not a regex etc..)
    # idea: make current file executable, or just chmod current file and specify +x or -r etc.. with examples given.
    # idea: home-manager switch command without having to leave nvim
  ];
}
