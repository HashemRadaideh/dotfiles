local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local lineCount = endLnum - lnum

  local function is_single_statement()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, lnum, endLnum, false)
    local count = 0

    local non_statement_patterns = { "^[{}()%[%]]$", "^then$", "^do$", "^end$", "^fi$", "^begin$", "^esac$" }
    for _, line in ipairs(lines) do
      local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")

      if trimmed ~= "" then
        local is_statement = true

        for _, pattern in ipairs(non_statement_patterns) do
          if trimmed:match(pattern) then
            is_statement = false
            break
          end
        end

        if is_statement then
          count = count + 1
        end
      end
    end

    return count == 1
  end

  local function is_foldable_block()
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]

    if not line then
      return false
    end

    local excluded_patterns = {
      "^%s*import%s+",
      "^%s*from%s+.*import",
      "^%s*/%*",
      "^%s*//",
      "^%s*#",
      "^%s*package%s+",
      "^%s*module%s+",
    }

    for _, pattern in ipairs(excluded_patterns) do
      if line:match(pattern) then
        return false
      end
    end

    return is_single_statement()
  end

  local function add_chunks(target_width)
    local cur_width = 0
    for _, chunk in ipairs(virtText) do
      local chunk_text = chunk[1]
      local chunk_width = vim.fn.strdisplaywidth(chunk_text)

      if target_width > cur_width + chunk_width then
        table.insert(newVirtText, chunk)
        cur_width = cur_width + chunk_width
      else
        chunk_text = truncate(chunk_text, target_width - cur_width)
        table.insert(newVirtText, { chunk_text, chunk[2] })
        return cur_width + vim.fn.strdisplaywidth(chunk_text)
      end
    end
    return cur_width
  end

  local function get_fold_content_with_highlighting()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, lnum, endLnum, false)
    local content_chunks = {}

    for line_idx, line in ipairs(lines) do
      local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")
      if trimmed ~= "" then
        local line_num = lnum + line_idx - 1

        local col = line:find("%S") or 1
        local highlight_chunks = {}
        local current_hl = nil
        local current_text = ""

        for i = col, #line do
          local char = line:sub(i, i)
          if char:match("%S") then
            local syn_id = vim.fn.synID(line_num + 1, i, 1)
            local hl_name = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")

            if hl_name ~= current_hl then
              if current_text ~= "" then
                table.insert(highlight_chunks, { current_text, current_hl or "Normal" })
              end
              current_hl = hl_name ~= "" and hl_name or "Normal"
              current_text = char
            else
              current_text = current_text .. char
            end
          elseif current_text ~= "" then
            current_text = current_text .. char
          end
        end

        if current_text ~= "" then
          current_text = current_text:gsub("%s+$", "")
          if current_text ~= "" then
            table.insert(highlight_chunks, { current_text, current_hl or "Normal" })
          end
        end

        if #content_chunks > 0 then
          table.insert(content_chunks, { " ", "Normal" })
        end

        for _, chunk in ipairs(highlight_chunks) do
          table.insert(content_chunks, chunk)
        end
      end
    end

    return content_chunks
  end

  if is_foldable_block() then
    local content_chunks = get_fold_content_with_highlighting()

    local content_width = 0
    for _, chunk in ipairs(content_chunks) do
      content_width = content_width + vim.fn.strdisplaywidth(chunk[1])
    end

    add_chunks(width - content_width - 10)

    if #content_chunks > 0 then
      table.insert(newVirtText, { " ", "Normal" })
      for _, chunk in ipairs(content_chunks) do
        table.insert(newVirtText, chunk)
      end
    end

    return newVirtText
  end

  local suffix = (" 󰁂 %d "):format(lineCount)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local cur_width = add_chunks(width - suffix_width)

  if cur_width < width - suffix_width then
    suffix = suffix .. (" "):rep(width - suffix_width - cur_width)
  end

  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "BufReadPost",
  opts = {
    fold_virt_text_handler = handler,
    open_fold_hl_timeout = 0,
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
    },
    close_fold_current_line_for_ft = {
      default = true,
    },
  },
  init = function()
    vim.o.foldenable = true
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
  end,
}
