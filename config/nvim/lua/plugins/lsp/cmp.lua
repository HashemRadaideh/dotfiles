return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      build = ":!make install_jsregexp",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },
    -- "onsails/lspkind.nvim",
  },
  config = function()
    local ok, cmp = pcall(require, "cmp")
    local snip_ok, luasnip = pcall(require, "luasnip")
    if not ok and not snip_ok then
      return
    end

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.setup({
      history = true,
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
      -- update_events = { "TextChanged", "TextChangedI" },
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
      },
    })

    -- local check_backspace = function()
    --   local col = vim.fn.col(".") - 1
    --   return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    -- end

    -- local function has_words_before()
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end

    -- local has_words_before2 = function()
    --   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    --     return false
    --   end
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    -- end

    local kind_icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
      Codeium = "",
      path = "/",
      nvim_lsp = "🤖",
      luasnip = "🆘",
      nvim_lua = "🌚",
      buffer = "🔄",
      Copilot = "",
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      -- completion = {
      --   completeopt = 'menu,menuone,noinsert',
      --   autocomplete = true
      -- },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip", group_index = 1 },
        { name = "path", group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "latex_symbols", group_index = 1 },
        { name = "copilot", group_index = 2 },
        { name = "codeium", group_index = 2 },
        { name = "render-markdown", group_index = 2 },
        -- { name = "buffer",          group_index = 3 },
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          local lspkind_ok, lspkind = pcall(require, "lspkind")
          if not lspkind_ok then
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = "[" .. entry.source.name .. "]"
            return vim_item
          else
            return lspkind.cmp_format({
              mode = "symbol_text",
              symbol_map = kind_icons,
            })(entry, vim_item)
          end
        end,
      },
      -- duplicates = {
      --   nvim_lsp = 1,
      --   luasnip = 1,
      --   cmp_tabnine = 1,
      --   buffer = 1,
      --   path = 1,
      -- },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      preselect = cmp.PreselectMode.None,
      experimental = {
        ghost_text = true,
      },
      -- view = {
      --   entries = "native",
      -- },
      mapping = {
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif luasnip.expandable() then
            --   luasnip.expand()
            -- elseif has_words_before() then
            --   cmp.complete()
            -- elseif check_backspace() then
            --   fallback()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif luasnip.expandable(-1) then
            luasnip.expand(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif luasnip.expandable(-1) then
            luasnip.expand(-1)
          else
            fallback()
          end
        end),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<C-space>"] = cmp.mapping({
          i = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
          c = function()
            if cmp.visible() then
              cmp.close()
            else
              cmp.complete()
            end
          end,
        }),
        ["<CR>"] = cmp.mapping.confirm(),
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })

    -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          -- option = { ignore_cmds = { "Man", "!" } },
        },
      }),
    })

    -- cmp.event:on(
    --   "confirm_done",
    --   require("nvim-autopairs.completion.cmp").on_confirm_done({
    --     mapchar = { tex = "" },
    --   })
    -- )
  end,
}

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     {
--       "L3MON4D3/LuaSnip",
--       build = "make install_jsregexp",
--       dependencies = {
--         "saadparwaiz1/cmp_luasnip",
--         "rafamadriz/friendly-snippets",
--       },
--     },
--   },
--   config = function()
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")
--
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.abort(),
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       }),
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "path" },
--       }, {
--         { name = "buffer" },
--       }),
--       formatting = {
--         format = function(entry, vim_item)
--           vim_item.menu = ({
--             nvim_lsp = "[LSP]",
--             luasnip = "[Snippet]",
--             buffer = "[Buffer]",
--             path = "[Path]",
--           })[entry.source.name]
--           return vim_item
--         end,
--       },
--       experimental = {
--         ghost_text = true,
--       },
--     })
--
--     cmp.setup.cmdline(":", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = "path" },
--       }, {
--         { name = "cmdline" },
--       }),
--     })
--
--     cmp.setup.cmdline({ "/", "?" }, {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = {
--         { name = "buffer" },
--       },
--     })
--   end,
-- }
