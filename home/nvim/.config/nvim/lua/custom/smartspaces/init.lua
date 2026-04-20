local config = require("custom.smartspaces.config")

local M      = {}
local ns     = vim.api.nvim_create_namespace("smartspaces")
local cache  = {}

local function setup_hl()
  local opts = config.options
  vim.api.nvim_set_hl(0, opts.hl.alignment, opts.alignment_hl_opts)
  if opts.overflow.enabled then
    vim.api.nvim_set_hl(0, opts.hl.overflow, opts.overflow.hl_opts)
  end
end

local function should_skip(bufnr)
  local bo   = vim.bo[bufnr]
  local opts = config.options
  return bo.buftype ~= ""
      or not bo.modifiable
      or not bo.buflisted
      or vim.tbl_contains(opts.ft_ignore, bo.filetype)
end

local function extract_clusters(groups, min_count, gap_mult, gap_floor)
  local alignment = {}
  for _, entries in pairs(groups) do
    if #entries < min_count then goto continue end

    table.sort(entries, function(a, b) return a.row < b.row end)

    local gaps = {}
    for i = 2, #entries do
      gaps[i - 1] = entries[i].row - entries[i - 1].row
    end

    table.sort(gaps)
    local max_gap = math.max(gaps[math.ceil(#gaps / 2)] * gap_mult, gap_floor)

    local cluster = { entries[1] }
    for i = 2, #entries do
      if gaps[i - 1] <= max_gap then
        table.insert(cluster, entries[i])
      else
        if #cluster >= min_count then
          for _, e in ipairs(cluster) do
            alignment[e.row .. "," .. e.col_start] = true
          end
        end
        cluster = { entries[i] }
      end
    end

    if #cluster >= min_count then
      for _, e in ipairs(cluster) do
        alignment[e.row .. "," .. e.col_start] = true
      end
    end

    ::continue::
  end

  return alignment
end

local function find_alignment_cols(lines)
  local opts     = config.options
  local by_start = {}
  local by_end   = {}

  for row, line in ipairs(lines) do
    for col_start, spaces in line:gmatch("()( +)") do
      if #spaces >= opts.min_spaces then
        local col_end       = col_start + #spaces - 1
        by_start[col_start] = by_start[col_start] or {}
        by_end[col_end]     = by_end[col_end] or {}
        local entry         = { row = row, col_start = col_start }
        table.insert(by_start[col_start], entry)
        table.insert(by_end[col_end], entry)
      end
    end
  end

  local args      = { opts.min_alignment_count, opts.gap_tolerance_mult, opts.min_gap_tolerance }
  local result    = extract_clusters(by_start, unpack(args))
  local by_end_ks = extract_clusters(by_end, unpack(args))
  for k in pairs(by_end_ks) do
    result[k] = true
  end

  return result
end

local function render(bufnr)
  if should_skip(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    cache[bufnr] = nil
    return
  end

  local tick = vim.api.nvim_buf_get_changedtick(bufnr)
  if cache[bufnr] == tick then return end
  cache[bufnr]    = tick

  local opts      = config.options
  local lines     = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local alignment = find_alignment_cols(lines)
  local tw        = opts.overflow.enabled and vim.bo[bufnr].textwidth or 0

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  for row, line in ipairs(lines) do
    local indent_end = #line:match("^%s*")

    for col_start, spaces in line:gmatch("()( +)") do
      if col_start > indent_end and #spaces >= opts.min_spaces then
        local hl = alignment[row .. "," .. col_start]
            and opts.hl.alignment
            or opts.hl.normal
        vim.api.nvim_buf_set_extmark(bufnr, ns, row - 1, col_start - 1, {
          virt_text     = { { opts.space_char:rep(#spaces), hl } },
          virt_text_pos = "overlay",
          hl_mode       = "combine",
          priority      = 10,
        })
      end
    end

    if tw > 0 and vim.fn.strdisplaywidth(line) > tw then
      local byte_col = vim.fn.byteidx(line, tw)
      if byte_col >= 0 and byte_col < #line then
        vim.api.nvim_buf_set_extmark(bufnr, ns, row - 1, byte_col, {
          end_row  = row - 1,
          end_col  = #line,
          hl_group = opts.hl.overflow,
          hl_mode  = "combine",
          priority = 20,
        })
      end
    end
  end
end

local function attach_autocmds()
  local group = vim.api.nvim_create_augroup("SmartSpaces", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group    = group,
    callback = setup_hl,
  })

  vim.api.nvim_create_autocmd("BufWipeout", {
    group    = group,
    callback = function(ev) cache[ev.buf] = nil end,
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
    group    = group,
    callback = function(ev) render(ev.buf) end,
  })
end

function M.setup(opts)
  config.set(opts)
  setup_hl()
  attach_autocmds()
end

return M
