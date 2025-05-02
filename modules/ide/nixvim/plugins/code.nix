{
  pkgs,
  config,
  ...
}: let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
  mkFun = x: mkRaw ("function () " + x + " end");
  mkCmd = x: "<cmd>" + x + "<CR>";
in {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "bash"
            "nix"
            "c"
            "cpp"
            "glsl"
            "lua"
            "python"
            "javascript"
            "html"
            "haskell"
            "ocaml"
            "rust"
          ];
          sync_install = false;
          highlight.enable = true;
          indent.enable = true;
          auto_install = false;
          ignore_install = [];
        };
      };

      lsp = {
        enable = true;
        onAttach = ''
          local nmap = function(keys, func, desc)
              if desc then
                  desc = 'LSP: ' .. desc
              end

              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          nmap('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')

          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<leader>dp', vim.lsp.buf.signature_help, '[D]ocument [P]arameters')
        '';
      };

      cmp = {
        enable = true;

        settings = {
          completion.completeopt = "menu,menuone,noinsert";
          snippet.expland = ''function(args) require('luasnip').lsp_expand(args.body) end'';

          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {
              name = "path";
              trailing_slash = true;
            }
            {name = "emoji";}
          ];

          mapping = {
            "<C-n>" = ''
              function()
                local cmp = require("cmp")
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  cmp.complete()
                end
              end
            '';
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp-path.enable = true;
      cmp-emoji.enable = true;

      comment.enable = true;

      dap.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-dap-ui
      nvim-dap-virtual-text
    ];

    extraConfigLua = ''
      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    '';

    keymaps = [
      # dap
      {
        mode = "n";
        key = "<leader>db";
        action = mkCmd "DapToggleBreakpoint";
        options.desc = "DAP: Add breakpoint at line";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = mkCmd "DapContinue";
        options.desc = "DAP: Start or continue the debugger";
      }
      {
        mode = "n";
        key = "<leader>dus";
        action = mkFun ''
          local widgets = require("dap.ui.widgets")
          local sidebar = widgets.sidebar(widgets.scopes)
          sidebar.open()
        '';
        options.desc = "DAP: Open debugging sidebar";
      }
    ];
  };
}
