return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },

    -- explorer
    {
      "<leader>fe",
      function() Snacks.explorer({ cwd = vim.uv.cwd() }) end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function() Snacks.explorer() end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },

    -- buffers
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },

    -- lsp keymaps are in ../core/lsp.lua

    -- find
    { "<leader><space>", function() Snacks.picker.files() end, desc = "Find Files (Root Dir)" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

    -- git
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Current File History", mode = "n" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log (cwd)", mode = "n" },
    { "<leader>gb", function() Snacks.picker.git_log_line() end, desc = "Git Blame Line", mode = "n" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- { "<leader>gY", function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end, desc = "Git Browse (copy)", mode = { "n", "x" }, },

    -- LazyGit (lazygit cmd required)
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", mode = "n" },

    -- Grep
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word() end,
      desc = "Visual selection or word (Root Dir)",
      mode = { "n" },
    },

    -- search
    { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },

    -- Toggle
    {
      "<leader>uA",
      function()
        Snacks.toggle
          .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
          :toggle()
      end,
      desc = "Toggle Tabline",
    },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>uD", function() Snacks.toggle.dim():toggle() end, desc = "Toggle Dim" },
    {
      "<leader>uL",
      function() Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle() end,
      desc = "Toggle Relative Number",
    },
    { "<leader>uS", function() Snacks.toggle.scroll():toggle() end, desc = "Toggle Scroll" },
    { "<leader>uT", function() Snacks.toggle.treesitter():toggle() end, desc = "Toggle Treesitter" },
    { "<leader>ua", function() Snacks.toggle.animate():toggle() end, desc = "Toggle Animate" },
    {
      "<leader>ub",
      function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end,
      desc = "Toggle Background",
    },
    {
      "<leader>uc",
      function()
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
          :toggle()
      end,
      desc = "Toggle Conceal Level",
    },
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },
    { "<leader>uh", function() Snacks.toggle.inlay_hints():toggle() end, desc = "Toggle Inlay Hints" },
    { "<leader>ug", function() Snacks.toggle.indent():toggle() end, desc = "Toggle Indent Guides" },
    { "<leader>ul", function() Snacks.toggle.line_number():toggle() end, desc = "Toggle Line Number" },
    {
      "<leader>us",
      function() Snacks.toggle.option("spell", { name = "Spelling" }):toggle() end,
      desc = "Toggle Spelling",
    },
    { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end, desc = "Toggle Wrap" },

    -- Terminal
    { "<c-/>", function() Snacks.terminal(nil) end, desc = "Terminal (Root Dir)", mode = "n" },
    { "<c-_>", function() Snacks.terminal(nil) end, desc = "which_key_ignore", mode = "n" },

    -- Scratch buffer
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- Profiler
    { "<leader>dpp", function() Snacks.toggle.profiler() end, desc = "Toggle Profiler" },
    { "<leader>dph", function() Snacks.toggle.profiler_highlights() end, desc = "Toggle Profiler Highlights" },
  },

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },

    explorer = {
      replace_netrw = true,
      trash = true,
    },

    gitbrowse = {
      url_patterns = {
        ["gitlab%..+%.ru"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
          permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
          commit = "/-/commit/{commit}",
        },
      },
    },

    picker = {
      hidden = true,
      ignored = true,
      supports_live = true,
    },

    scroll = { enabled = false },
    indent = { enabled = true, char = "│" },
    notify = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
  },
}
