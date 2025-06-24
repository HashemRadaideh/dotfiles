vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.jobstart({ "ruff", "check", "--fix", filepath }, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, code)
        if code < 0 then
          vim.notify("ruff fix failed with code: " .. code, vim.log.levels.ERROR)
          return
        end

        vim.cmd("checktime")
      end,
    })
  end,
})
