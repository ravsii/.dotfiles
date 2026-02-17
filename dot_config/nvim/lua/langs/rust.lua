require("install"):add_mason({ "rust_analyzer" }):add_lsp_enable_exclude({ "rust_analyzer" }):add_treesitter({ "rust" })

return {
  {
    "Saecki/crates.nvim",
    ft = "toml",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set(
            "n",
            "<leader>cR",
            function() vim.cmd.RustLsp("codeAction") end,
            { desc = "Code Action", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
            function() vim.cmd.RustLsp({ "hover", "actions" }) end,
            { silent = true, buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<leader>dr",
            function() vim.cmd.RustLsp("debuggables") end,
            { desc = "Rust Debuggables", buffer = bufnr }
          )
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust if using rust-analyzer
            checkOnSave = true,
            -- Enable diagnostics if using rust-analyzer
            diagnostics = { enable = true },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local mr = require("mason-registry")

      if mr.has_package("codelldb") then
        local path = vim.fn.stdpath("data") .. "/mason/registry/packages/codelldb"
        local codelldb = path .. "/extension/adapter/codelldb"
        local library_path = path .. "/extension/lldb/lib/liblldb.dylib"
        local uname = io.popen("uname"):read("*l")
        if uname == "Linux" then
          library_path = package .. "/extension/lldb/lib/liblldb.so"
        end
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.rust = vim.tbl_deep_extend("keep", { lsp_format = "last" }, { "dioxus_fmt" })
      opts.formatters = {
        dioxus_fmt = {
          command = "dx",
          args = { "fmt", "--file", "$FILENAME" },
          stdin = false,
        },
      }
    end,
  },
}
