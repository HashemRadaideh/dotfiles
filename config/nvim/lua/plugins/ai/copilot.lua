return {
  "zbirenbaum/copilot.lua",
  lazy = false,
  -- cmd = "Copilot",
  -- event = "InsertEnter",
  dependencies = {
    {
      "copilotlsp-nvim/copilot-lsp",
      init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")

        vim.keymap.set("n", "<tab>", function()
          local bufnr = vim.api.nvim_get_current_buf()
          local state = vim.b[bufnr].nes_state
          if state then
            local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
              or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
            return nil
          else
            return "<C-i>"
          end
        end, { desc = "Accept Copilot NES suggestion", expr = true })
      end,
    },
    {
      "fang2hou/blink-copilot",
    },
  },
  opts = {
    -- https://docs.github.com/en/copilot/reference/ai-models/supported-models
    copilot_model = "claude-sonnet-4.5",
    panel = {
      enabled = true,
      auto_refresh = true,
      layout = {
        position = "right", -- bottom | top | left | right | horizontal | vertical
        ratio = 0.3,
      },
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      hide_during_completion = false,
      -- keymap = {
      --   accept = "<tab>",
      --   next = "<M-]>",
      --   prev = "<M-[>",
      --   dismiss = "<C-]>",
      -- },
    },
    nes = {
      enabled = false,
      auto_trigger = false,
      -- keymap = {
      --   accept_and_goto = "<C-i>",
      --   accept = "<s-tab>",
      --   dismiss = "<Esc>",
      -- },
    },
  },
}
