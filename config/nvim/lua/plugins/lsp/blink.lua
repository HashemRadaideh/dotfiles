return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
    "rafamadriz/friendly-snippets",
  },
  version = "1.*",
  opts = {
    keymap = {
      preset = "none",

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },
      ["<CR>"] = { "accept", "fallback" },

      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return (
              require("copilot-lsp.nes").apply_pending_nes()
              and require("copilot-lsp.nes").walk_cursor_end_edit()
            )
          end
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },

      -- ["<Tab>"] = {
      --   function(cmp)
      --     if cmp.snippet_active() then
      --       return cmp.accept()
      --     else
      --       return cmp.select_and_accept()
      --     end
      --   end,
      --   "snippet_forward",
      --   "fallback",
      -- },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
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
      ghost_text = {
        enabled = true,
      },
      menu = {
        border = "none",
        draw = {
          align_to = "label", -- 'none' to disable, 'cursor' to align to the cursor, or component
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
    signature = { enabled = true },
    sources = {
      default = { "avante", "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          score_offset = 80,
          opts = {},
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 75,
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    cmdline = {
      completion = {
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
