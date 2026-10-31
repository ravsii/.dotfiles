local parsers = { "lua", "luadoc", "vim", "vimdoc", "go", "gomod", "gowork", "gosum", "markdown", "markdown_inline" }

local function build_parser(data, target)
  local result = vim.system({ "make", target }, { cwd = data.path }):wait()
  if result.code ~= 0 then
    vim.notify(data.spec.name .. " build failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
  end
end

require("utils.pack_changed").on_change("tree-sitter-ghostty", function(data)
  build_parser(data, "nvim_install")
end)

require("utils.pack_changed").on_change("nvim-treesitter", function()
  vim.schedule(function() vim.cmd.TSUpdate() end)
end)

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/bezhermoso/tree-sitter-ghostty",
})

local treesitter = require("nvim-treesitter")
treesitter.setup()
treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(event)
    if vim.treesitter.get_parser(event.buf, nil, { error = false }) then
      vim.treesitter.start(event.buf)
    end
  end,
})

require("nvim-treesitter-textobjects").setup({ move = { set_jumps = true } })
require("treesitter-context").setup({
  enable = true,
  multiwindow = true,
  max_lines = 3,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "outer",
  mode = "topline",
})

vim.keymap.set("x", "[n", function() require("vim.treesitter._select").select_prev(vim.v.count1) end, { desc = "Select previous treesitter node" })
vim.keymap.set("x", "]n", function() require("vim.treesitter._select").select_next(vim.v.count1) end, { desc = "Select next treesitter node" })

vim.keymap.set({ "n", "x", "o" }, "<C-Space>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer LSP selection" })

vim.keymap.set({ "n", "x", "o" }, "<BS>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner LSP selection" })

vim.keymap.set("n", "<M-h>", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, { desc = "Swap previous parameter" })
vim.keymap.set({ "n", "x", "o" }, "<M-l>", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, { desc = "Swap next parameter" })

for _, binding in ipairs({
  { "]f", "@function.outer", "next", "goto_next_start" },
  { "[f", "@function.outer", "previous", "goto_previous_start" },
  { "]a", "@parameter.outer", "next", "goto_next_start" },
  { "[a", "@parameter.outer", "previous", "goto_previous_start" },
  { "]c", "@class.outer", "next", "goto_next_start" },
  { "[c", "@class.outer", "previous", "goto_previous_start" },
}) do
  local key, capture, direction, method = unpack(binding)
  vim.keymap.set({ "n", "x", "o" }, key, function()
    require("nvim-treesitter-textobjects.move")[method](capture)
  end, { desc = direction .. " " .. capture })
end
