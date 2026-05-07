-- local dap = require("dap")
--
-- dap.configurations.java = {
--   {
--     type = "java",
--     request = "attach",
--     name = "Attach to running JVM",
--     hostName = "127.0.0.1",
--     port = function()
--       return tonumber(vim.fn.input("Debug Port: ", "5005"))
--     end,
--   },
-- }
--
-- dap.adapters.java = function(callback, config)
--   if config.request ~= "attach" then
--     callback({
--       type = "server",
--       host = "127.0.0.1",
--       port = function()
--         return tonumber(vim.fn.input("Debug Port: ", "5005"))
--       end,
--     })
--   end
-- end
--
-- dap.adapters["java-attach"] = function(callback, config)
--   callback({
--     type = "server",
--     host = "127.0.0.1",
--     port = function()
--       return tonumber(vim.fn.input("Debug Port: ", "5005"))
--     end,
--   })
-- end
--
-- dap.configurations.java = dap.configurations.java or {}
-- table.insert(dap.configurations.java, {
--   type = "java",
--   request = "attach",
--   name = "Attach to JDWP (runner --debug)",
--   hostName = "127.0.0.1",
--   port = function()
--     return tonumber(vim.fn.input("Debug Port: ", "5005"))
--   end,
-- })

vim.defer_fn(function()
  local dap = require("dap")
  local nvim_java_adapter = dap.adapters.java

  dap.adapters.java = function(callback, config)
    if config.request ~= "attach" then
      return nvim_java_adapter(callback, config)
    end

    local clients = vim.lsp.get_clients({ name = "jdtls" })
    if #clients == 0 then
      vim.notify("[dap] jdtls not attached", vim.log.levels.ERROR)
      return
    end

    clients[1]:request("workspace/executeCommand", { command = "vscode.java.startDebugSession" }, function(err, port)
      if err then
        vim.notify("[dap]" .. err.message, vim.log.levels.ERROR)
        return
      end
      callback({ type = "server", host = "127.0.0.1", port = port })
    end)
  end

  dap.configurations.java = dap.configurations.java or {}
  table.insert(dap.configurations.java, {
    type = "java",
    request = "attach",
    name = "Attach to JDWP (runner --debug)",
    hostName = "127.0.0.1",
    port = function()
      return tonumber(vim.fn.input("Debug Port: ", "5005"))
    end,
  })
end, 100)

local jdtls_opts = {
  settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
          -- url = vim.fn.getenv("XDG_CONFIG_HOME") .. "/JetBrains/IntelliJIdea2025.3/codestyles/intellij-code-style.xml",
          -- profile = "IntellijCodeStyle",
        },
      },
      maven = {
        userSettings = "~/.m2/settings.xml",
        downloadSources = false,
        updateSnapshots = false,
      },
      eclipse = {
        downloadSources = false,
      },
      autobuild = {
        enabled = false,
      },
    },
  },
}

require("java").setup({
  jdtls = jdtls_opts,
})

return jdtls_opts
