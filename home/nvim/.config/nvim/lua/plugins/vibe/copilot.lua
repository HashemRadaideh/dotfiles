return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    {
      "copilotlsp-nvim/copilot-lsp",
      init = function()
        vim.g.copilot_nes_debounce = 500
      end,
    },
  },
  opts = {
    -- https://docs.github.com/en/copilot/reference/ai-models/supported-models
    copilot_model = "gpt-41-copilot",
    panel = {
      enabled = false,
      auto_refresh = false,
      -- layout = {
      --   position = "right", -- bottom | top | left | right | horizontal | vertical
      --   ratio = 0.3,
      -- },
      -- keymap = {
      --   jump_prev = "[[",
      --   jump_next = "]]",
      --   accept = "<CR>",
      --   refresh = "gr",
      --   open = "<M-CR>",
      -- },
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