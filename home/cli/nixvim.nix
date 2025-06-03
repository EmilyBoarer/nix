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
            " █████   █████ █████ ██████   ██████ █████ █████    █████ █████"
            "░░███   ░░███ ░░███ ░░██████ ██████ ░░███ ░░███    ░░███ ░░███ "
            " ░███    ░███  ░███  ░███░█████░███  ░███  ░███     ░░███ ███  "
            " ░███    ░███  ░███  ░███░░███ ░███  ░███  ░███      ░░█████   "
            " ░░███   ███   ░███  ░███ ░░░  ░███  ░███  ░███       ░░███    "
            "  ░░░█████░    ░███  ░███      ░███  ░███  ░███      █ ░███    "
            "    ░░███      █████ █████     █████ █████ ███████████ █████   "
            "     ░░░      ░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░░░░░░░ ░░░░░    "
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
      # TODO: configure the default shortcuts to not use Telescope (not using, so breaks!)
    };

    # Show prompt when pressing the <leader> key, to help remind what shortcuts are available and what they do
    which-key.enable = true;
    # NB: menu layout configured below with the keymaps

    # Git Plugins:
    gitblame = {
      enable = true;
      # TODO: disable by default
      settings = {
        message_template = " <author>, <date>";
        date_format = "%a %d %b %Y";
      };
    };
    lazygit.enable = true; # TODO how to use?

    # Show tabs for different open buffers
    barbar = {
      enable = true;
    };

    # File Explorere sidebar
    web-devicons.enable = true;
    nvim-tree = {
      enable = true;
      modified.enable = true;
      # show all dotfiles and dotdirs, but hide .git dir:
      filters.custom = [
        ".git"
      ];
    };

    ## TODO: fzf - fuzzy finder and grep things? 'telescope' is also an alternative worth trying out
    ## TODO: fterm - floating terminal?

    # TODO: treesitter - duplicate of LSP or a good addition?
    # TODO: auto completion? get it to look up in the open source sourcecode, so no need to have all the web browsers open all the time for the repos.

    # TODO: don't allow file write if code will error? (temporarily good, only if can get large codebases to stop giving false-positives for errors)

    # Automatically pair brackets:
    nvim-autopairs.enable = true; # TODO also autocomplete semicolons after `{}` in nix files? how? LSP do a better job at this sort of thing?

    # Colour hexcodes etc.. inline:
    colorizer = {
      enable = true;
      settings.names = false;
    };

    ## TODO explore nvim-surround.enable = true;
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
    # TODO idea: toggle relative line numbers for `d` and `y` then back to regular numbers afterwards
    #{ key = "<leader>g"; options.desc = "`grep -r` in directory"; action = ""; }
    # idea: g -> grep -r in directory
    # idea: fuzzy finder or similarly search for similar looking things (not a regex etc..)
    # idea: make current file executable, or just chmod current file and specify +x or -r etc.. with examples given.
    # idea: home-manager switch command without having to leave nvim
    # Nix shortcuts:
    { key = "<leader>r"; options.desc = "Reload: Test out new config"; action = ":source $MYVIMRC<CR>"; }
    { key = "<leader>nhs"; options.desc = "Home-manager switch"; action = ":terminal home-manager switch<CR>"; } # TODO launch the terminal in a better way!
    # Git shortcuts:
    { key = "<leader>gb"; options.desc = "Git: Toggle Inline Blame"; action = ":GitBlameToggle<CR>"; }
    # File manager:
    { key = "<leader>f"; options.desc = "Toggle File Tree Visibility"; action = ":NvimTreeToggle<CR>"; }
  ];
  # Specify Groups of keymaps for which-key
  plugins.which-key.settings.spec = [
    { # Git
      __unkeyed = "<leader>g";
      group = "Git";
      icon = "";
    }
    { # Nix
      __unkeyed = "<leader>n";
      group = "Nix etc..";
      icon = "󱄅";
    }
    { # Nix: Home-Manager
      __unkeyed = "<leader>nh";
      group = "Home-Manager";
      icon = "🏠";
    }
    { # Nix: NixOS
      __unkeyed = "<leader>no";
      group = "NixOS";
      icon = "";
    }
    { # Debugging: TODO add commands for this category
      __unkeyed = "<leader>d";
      group = "Debugging";
      icon = "";
    }
    { # Grep, Goto definition, etc..
      __unkeyed = "<leader>h"; # optimise for home-row!
      group = "Navigate Codebase";
      icon = "󰥩";
    }
  ];
}
