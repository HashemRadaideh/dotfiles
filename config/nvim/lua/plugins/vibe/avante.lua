return {
  "yetone/avante.nvim",
  version = false, -- track main, never pin to "*"
  build = vim.fn.has("win32") ~= 0 and
      "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or
      "make", -- "make BUILD_FROM_SOURCE=true",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons", -- echasnovski/mini.icons
    "zbirenbaum/copilot.lua",
    "MeanderingProgrammer/render-markdown.nvim",
    "folke/snacks.nvim",
    "saghen/blink.compat",
    -- "HakonHarnes/img-clip.nvim",
  },
  opts = {
    mode = "agentic",
    -- "agentic" → AI calls tools automatically (create/edit files, bash, web search…)
    -- "legacy"  → classic planning/diff, no auto tool execution
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    cursor_applying_provider = "copilot",
    providers = {
      copilot = {
        model = "gpt-4.1", -- "claude-sonnet-4.6"
        timeout = 60000,
        extra_request_body = {
          temperature = 0.6,
          max_tokens = 16000,
        },
      },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,
      enable_token_counting = true,
      auto_add_current_file = false,
      auto_approve_tool_permissions = false,
      confirmation_ui_style = "inline_buttons",
      acp_follow_agent_locations = true,
    },
    shortcuts = {
      {
        name = "refactor",
        description = "Refactor for readability & best practices",
        details = "Improve structure, naming, and maintainability while preserving behavior",
        prompt =
        "Refactor this code following best practices. Improve readability, naming, and maintainability without changing behavior. Add brief comments where the intent is non-obvious.",
      },
      {
        name = "tests",
        description = "Generate unit tests",
        details = "Write comprehensive tests covering happy paths, edge cases, and error scenarios",
        prompt =
        "Write comprehensive unit tests for this code. Cover happy paths, edge cases, and error/exception scenarios. Use the testing framework already present in the project.",
      },
      {
        name = "explain",
        description = "Explain this code in depth",
        details = "Line-by-line walkthrough with context on why it works the way it does",
        prompt =
        "Explain this code in depth. Walk through what each part does and why, including any non-obvious design decisions or potential gotchas.",
      },
      {
        name = "review",
        description = "Code review — bugs, perf, security",
        details = "Critical review for correctness, performance, and security",
        prompt =
        "Do a thorough code review. Flag any bugs, performance issues, security vulnerabilities, or violations of good practice. Be direct and specific.",
      },
      {
        name = "docstring",
        description = "Add documentation / Javadoc",
        details = "Generate appropriate doc comments for the selected code",
        prompt =
        "Add appropriate documentation comments to this code. Match the style of the project (Javadoc for Java, etc.). Document parameters, return values, exceptions, and intent.",
      },
      {
        name = "fix",
        description = "Find and fix the bug",
        details = "Identify the root cause and produce a corrected version",
        prompt = "Find the bug in this code. Explain the root cause, then provide the corrected version.",
      },
      {
        name = "simplify",
        description = "Simplify / reduce complexity",
        details = "Reduce nesting, duplication, or unnecessary complexity",
        prompt =
        "Simplify this code. Reduce unnecessary complexity, nesting, or duplication while keeping it fully correct and readable.",
      },
    },
    mappings = {
      diff = {
        ours       = "co",
        theirs     = "ct",
        all_theirs = "ca",
        both       = "cb",
        cursor     = "cc",
        next       = "]x",
        prev       = "[x",
      },
      suggestion = {
        accept  = "<M-l>",
        next    = "<M-]>",
        prev    = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-c>", "<Esc>", "q" },
        insert = { "<C-c>" },
      },
      sidebar = {
        apply_all              = "A",
        apply_cursor           = "a",
        retry_user_request     = "r",
        edit_user_request      = "e",
        switch_windows         = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file            = "d",
        add_file               = "@",
        close                  = { "<Esc>", "q" },
      },
    },
    windows = {
      position       = "right",
      wrap           = true,
      width          = 35,
      sidebar_header = {
        enabled = true,
        align   = "center",
        rounded = true,
      },
      spinner        = {
        editing    = { "⡀", "⠄", "⠂", "⠁", "⠈", "⠐", "⠠", "⢀", "⣀", "⢄", "⢂", "⢁", "⢈", "⢐", "⢠", "⣠", "⢤", "⢢", "⢡", "⢨", "⢰", "⣰", "⢴", "⢲", "⢱", "⢸", "⣸", "⢼", "⢺", "⢹", "⣹", "⢽", "⢻", "⣻", "⢿", "⣿" },
        generating = { "·", "✢", "✳", "∗", "✻", "✽" },
        thinking   = { "🤔", "💭", "🧠", "⚡" },
      },
      input          = {
        prefix = "󱜸 ",
        height = 10,
      },
      edit           = {
        border       = "rounded",
        start_insert = true,
      },
      ask            = {
        floating       = false,
        start_insert   = true,
        border         = "rounded",
        focus_on_apply = "ours",
      },
    },
    selector = {
      provider = "fzf",
      provider_opts = {},
    },
    input = {
      provider = "snacks",
      provider_opts = {
        title = "Avante",
        icon  = "󱜸 ",
      },
    },
    highlights = {
      diff = {
        current  = "DiffText",
        incoming = "DiffAdd",
      },
    },
    diff = {
      autojump            = true,
      list_opener         = "copen",
      override_timeoutlen = 500,
    },
    suggestion = {
      debounce = 800,
      throttle = 800,
    },
    web_search_engine = {
      provider = "tavily",
      proxy    = nil,
    },
    prompt_logger = {
      enabled     = true,
      log_dir     = vim.fn.stdpath("cache") .. "/avante_prompts",
      next_prompt = { normal = "<C-n>", insert = "<C-n>" },
      prev_prompt = { normal = "<C-p>", insert = "<C-p>" },
    },
    instructions_file = ".avante/rules.md",
  },
  config = function(_, opts)
    vim.opt.laststatus = 3

    require("avante").setup(opts)

    vim.keymap.set("v", "<leader>ae", function()
      require("avante.api").edit()
    end, { desc = "Avante: edit selection" })

    vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<CR>", { desc = "Avante: toggle sidebar" })
    vim.keymap.set("n", "<leader>an", "<cmd>AvanteChatNew<CR>", { desc = "Avante: new chat" })
    vim.keymap.set("n", "<leader>ah", "<cmd>AvanteHistory<CR>", { desc = "Avante: chat history" })
    vim.keymap.set("n", "<leader>am", "<cmd>AvanteModels<CR>", { desc = "Avante: pick model" })

    vim.keymap.set("n", "<leader>az", function()
      vim.defer_fn(function()
        require("avante.api").zen_mode()
      end, 100)
    end, { desc = "Avante: zen mode" })
  end,
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = "v",
    },
    {
      "<leader>av",
      function()
        require("avante.api").toggle()
      end,
      desc = "avante: toggle",
      mode = { "n", "v" },
    },
  },
}
