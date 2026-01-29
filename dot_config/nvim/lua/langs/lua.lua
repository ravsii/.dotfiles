require("install"):add_mason({ "stylua" })

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
    },
    opts = { adapters = {
      ["neotest-plenary"] = {},
    } },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jbyuki/one-small-step-for-vimkind",
        keys = {
          {
            "<leader>dn",
            function() require("osv").launch({ port = 8086 }) end,
            mode = "n",
            noremap = true,
            desc = "Neovim osv enable",
          },
        },
        config = function()
          local dap = require("dap")

          dap.adapters.nlua = function(callback, config)
            callback({
              type = "server",
              host = config.host or "127.0.0.1",
              port = config.port or 8086,
            })
          end

          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
              host = function() return "127.0.0.1" end,
              port = function() return 8086 end,
            },
          }
        end,
      },
    },
  },
}
