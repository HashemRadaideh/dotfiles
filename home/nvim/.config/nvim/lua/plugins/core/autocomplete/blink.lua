return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
    "rafamadriz/friendly-snippets",
    "fang2hou/blink-copilot",
    { "saghen/blink.compat", opts = { impersonate_nvim_cmp = true } },
  },
  version = "1.*",
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return (
              require("copilot-lsp.nes").apply_pending_nes()
              and require("copilot-lsp.nes").walk_cursor_end_edit()
            )
          elseif cmp.snippet_active() then
            return cmp.accept()
          end
          return cmp.select_next()
        end,
        "snippet_forward",
        "select_next",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings", "fallback" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback_to_mappings", "fallback" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings", "fallback" },
      ["<C-h>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-s>"] = { "show_documentation", "hide_documentation", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = {
        AvanteCmd = "",
        AvanteMention = "",
      },
    },
    completion = {
      documentation = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = false,
        show_with_menu = true,
      },
      menu = {
        auto_show = true,
        border = "none",
        draw = {
          align_to = "label",
          padding = 0,
          gap = 1,
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            source_name = {
              width = { max = 30 },
              text = function(ctx)
                return string.format("[%s]", ctx.source_name)
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
    },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "avante_commands",
        "avante_mentions",
        "avante_files",
        "avante_shortcuts",
        "copilot",
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 90,
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000,
          opts = {},
        },
        avante_files = {
          name = "avante_files",
          module = "blink.compat.source",
          score_offset = 100,
          opts = {},
        },
        avante_shortcuts = {
          name = "avante_shortcuts",
          module = "blink.compat.source",
          score_offset = 1000,
          opts = {},
        },
      },
    },
    signature = { enabled = true },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    cmdline = {
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = {
          auto_show = vim.g.vscode == nil,
        },
      },
    },
  },
  opts_extend = {
    "sources.default",
  },
}
