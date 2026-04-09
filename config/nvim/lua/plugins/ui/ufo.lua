local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local lineCount = endLnum - lnum
  local bufnr = vim.api.nvim_get_current_buf()

  local ELLIPSIS_PATTERNS = {
    "^%s*import%s+",
    "^%s*import%s+.*from",
    "^%s*from%s+.*import",
    "^%s*use%s+",
    "^%s*pub%s+.*use%s+",
    "^%s*include%s+",
    "^%s*/%*",
    "^%s*//",
    "^%s*#",
  }

  local NON_STATEMENT_PATTERNS = {
    "^[{}()%[%]]$",
    "^begin$",
    "^then$",
    "^do$",
    "^end$",
    "^fi$",
    "^esac$",
  }

  local function get_line(n)
    return vim.api.nvim_buf_get_lines(bufnr, n - 1, n, false)[1]
  end

  local function get_lines(from, to)
    return vim.api.nvim_buf_get_lines(bufnr, from, to, false)
  end

  local function matches_any(str, patterns)
    for _, p in ipairs(patterns) do
      if str:match(p) then return true end
    end
    return false
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

  local function is_ellipsis_fold()
    local line = get_line(lnum)
    return line and matches_any(line, ELLIPSIS_PATTERNS)
  end

  local function is_oneliner_fold()
    local line = get_line(lnum)
    if not line or matches_any(line, ELLIPSIS_PATTERNS) then return false end

    local count = 0
    for _, l in ipairs(get_lines(lnum, endLnum)) do
      local trimmed = l:gsub("^%s+", ""):gsub("%s+$", "")
      if trimmed ~= "" and not matches_any(trimmed, NON_STATEMENT_PATTERNS) then
        count = count + 1
      end
    end
    return count == 1
  end

  local function get_highlighted_chunks(from, to)
    local chunks = {}
    for line_idx, line in ipairs(get_lines(from, to)) do
      local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")
      if trimmed ~= "" then
        local line_num = from + line_idx
        local col = line:find("%S") or 1
        local cur_hl, cur_text = nil, ""

        local function flush()
          if cur_text ~= "" then
            table.insert(chunks, { cur_text, cur_hl or "Normal" })
            cur_text = ""
          end
        end

        for i = col, #line do
          local char = line:sub(i, i)
          if char:match("%S") then
            local syn_id = vim.fn.synID(line_num, i, 1)
            local hl = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")
            hl = hl ~= "" and hl or "Normal"
            if hl ~= cur_hl then
              flush()
              cur_hl = hl
            end
            cur_text = cur_text .. char
          elseif cur_text ~= "" then
            cur_text = cur_text .. char
          end
        end

        cur_text = cur_text:gsub("%s+$", "")
        flush()

        if #chunks > 0 then
          table.insert(chunks, #chunks, { " ", "Normal" })
        end
      end
    end
    return chunks
  end

  if is_ellipsis_fold() then
    local line    = get_line(lnum)
    local indent  = line:match("^(%s*)") or ""
    local keyword = line:match("^%s*(%S+)") or ""
    local closing = keyword:match("^/%*") and " */" or ""

    table.insert(newVirtText, { indent, "Normal" })
    table.insert(newVirtText, { keyword .. " …" .. closing, "NonText" })
    return newVirtText
  end

  if is_oneliner_fold() then
    local content_chunks = get_highlighted_chunks(lnum, endLnum)
    local content_width = 0
    for _, chunk in ipairs(content_chunks) do
      content_width = content_width + vim.fn.strdisplaywidth(chunk[1])
    end

    add_chunks(width - content_width - 10)
    table.insert(newVirtText, { " ", "Normal" })
    for _, chunk in ipairs(content_chunks) do
      table.insert(newVirtText, chunk)
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
