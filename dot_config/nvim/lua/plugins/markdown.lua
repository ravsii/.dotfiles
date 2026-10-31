require("utils.pack_changed").on_change("markdown-preview.nvim", function()
  vim.cmd.packadd("markdown-preview.nvim")
  vim.fn["mkdp#util#install_sync"](true)
end)

vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
})

require("render-markdown").setup({
  file_types = { "markdown" },
  injections = { gitcommit = { enabled = false } },
})

local function set_markdown_keymaps(buf)
  require("which-key").add({
    { "<leader>M", group = "Markdown", mode = "n", buffer = buf },
  })

  for _, key in ipairs({
    { "<leader>Mm", "buf_toggle", "Toggle Markdown rendering" },
    { "<leader>Mp", "preview", "Markdown preview in split" },
    { "<leader>M+", "expand", "Expand anti-conceal margin" },
    { "<leader>M-", "contract", "Reduce anti-conceal margin" },
  }) do
    vim.keymap.set("n", key[1], function() require("render-markdown")[key[2]]() end, {
      buffer = buf,
      desc = key[3],
    })
  end

  vim.keymap.set("n", "<leader>Mp", "<cmd>MarkdownPreviewToggle<cr>", {
    buffer = buf,
    desc = "Toggle Markdown browser preview",
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event) set_markdown_keymaps(event.buf) end,
})

-- Подхватываем Markdown-буферы, открытые до загрузки модуля.
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "markdown" then
    set_markdown_keymaps(buf)
  end
end
