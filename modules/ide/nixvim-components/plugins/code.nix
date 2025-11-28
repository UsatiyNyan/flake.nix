{
  pkgs,
  lib,
  my,
  ...
}: let
  helpers = my.lib.nixvim lib;
  inherit (helpers) mkFun mkCmd;
in {
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "bash"
          "html"
          "python"
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

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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

    dap.enable = true;

    comment.enable = true;
    treesitter-textobjects.enable = true;
    nvim-surround.enable = true;

    nvim-ufo = {
      enable = true;
      settings.provider_selector = ''
        function(bufnr, filetype, buftype)
          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          for _, client in ipairs(clients) do
            if client.server_capabilities.foldingRangeProvider then
              return { "lsp", "indent" }
            end
          end
          return { "treesitter", "indent" }
        end
      '';
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-dap-ui
    nvim-dap-virtual-text
    promise-async
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
}
