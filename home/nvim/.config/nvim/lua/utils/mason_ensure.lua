local M = {}
local _seen = {}

function M.ensure(tools)
  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    return
  end

  for _, name in ipairs(tools) do
    if not _seen[name] then
      _seen[name] = true
      local pkg_ok, pkg = pcall(registry.get_package, name)
      if pkg_ok and not pkg:is_installed() then
        vim.notify("[mason] installing " .. name, vim.log.levels.INFO)
        pkg:install():once(
          "closed",
          vim.schedule_wrap(function()
            vim.cmd("silent! LspStart")
          end)
        )
      end
    end
  end
end

return M