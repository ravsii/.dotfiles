require("install"):add_mason({ "stylua" })

return {
  {
    "nvim-neotest/neotest",
    dependencies = { "HiPhish/neotest-busted" },
    opts = { adapters = { ["neotest-busted"] = {} } },
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
