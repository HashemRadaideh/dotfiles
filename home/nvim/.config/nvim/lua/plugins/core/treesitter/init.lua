return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local _installed = nil
    local _queries = {}

    local function get_installed(update)
      if update then
        _installed, _queries = {}, {}

        for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
          _installed[lang] = true
        end
      end

      return _installed or {}
    end

    local function have_query(lang, query)
      local key = lang .. ":" .. query

      if _queries[key] == nil then
        _queries[key] = vim.treesitter.query.get(lang, query) ~= nil
      end

      return _queries[key]
    end

    local function have(what, query)
      what = what or vim.api.nvim_get_current_buf()
      what = type(what) == "number" and vim.bo[what].filetype or what
      local lang = vim.treesitter.language.get_lang(what)

      if lang == nil or get_installed()[lang] == nil then
        return false
      end

      if query and not have_query(lang, query) then
        return false
      end

      return true
    end

    local parsers = require("nvim-treesitter").get_available()

    if not parsers or #parsers == 0 then
      return
    end

    local ft_to_attach = {}
    for _, parser in ipairs(parsers) do
      local filetypes = vim.treesitter.language.get_filetypes(parser)

      if filetypes and #filetypes > 0 then
        for _, ft in ipairs(filetypes) do
          if not vim.tbl_contains(ft_to_attach, ft) then
            table.insert(ft_to_attach, ft)
          end
        end
      end
    end

    local function start_treesitter(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      local ok, _ = pcall(vim.treesitter.start, bufnr)

      if not ok then
        return
      end

      if have("folds", "folds") then
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end

      if have("indent", "indents") then
        vim.bo[bufnr].indentexpr = "v:lua.require'utils'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft_to_attach,
      callback = function(event)
        local bufnr = event.buf
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

        local parser_name = vim.treesitter.language.get_lang(filetype)
        if not parser_name then
          return
        end

        if not have(filetype) then
          require("nvim-treesitter").install({ parser_name }):await(function()
            start_treesitter(bufnr)
          end)
          return
        end

        start_treesitter(bufnr)
      end,
    })
  end,
}
