return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  config = function()
    -- -- local mason_registry = require("mason-registry")
    -- -- local codelldb = mason_registry.get_package("codelldb")
    -- -- local extension_path = codelldb:get_install_path() .. "/extension"

    -- local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"

    -- local codelldb_path = extension_path .. "adapter/codelldb"
    -- local liblldb_path = extension_path .. "lldb/lib/liblldb"
    -- local this_os = vim.uv.os_uname().sysname

    -- if this_os:find("Windows") then
    --   codelldb_path = extension_path .. "adapter\\codelldb.exe"
    --   liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    -- else
    --   liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    -- end

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "rust",
      group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })

    vim.g.rustaceanvim = {
      -- dap = {
      --   adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
      -- },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            lens = {
              debug = {
                enable = true,
              },
              enable = true,
              implementations = {
                enable = true,
              },
              references = {
                adt = {
                  enable = true,
                },
                enumVariant = {
                  enable = true,
                },
                method = {
                  enable = true,
                },
                trait = {
                  enable = true,
                },
              },
              run = {
                enable = true,
              },
              updateTest = {
                enable = true,
              },
            },
          },
        },
      },
    }
  end,
}