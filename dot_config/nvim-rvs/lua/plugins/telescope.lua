return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys= {
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader><space>",  "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    -- find
    { "<leader>fc", function() 
 local builtin = require("telescope.builtin")
      CONFIG_HOME = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config/nvim"
      local fk_opts = {
        cwd = vim.env.XDG_CONFIG_HOME,
        results_title = "Config",
      }
     builtin.find_files(fk_opts)
    end , desc = "Find Config File" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    -- { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
      },
      opts=function() 
local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close
            }
          }
        }
      }
    end
    }
