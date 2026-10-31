require("utils.pack_changed").on_change("swagger-preview.nvim", function(data)
  local result = vim.system({ "npm", "install" }, { cwd = data.path }):wait()
  if result.code ~= 0 then
    vim.notify("swagger-preview.nvim npm install failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
  end
end)

vim.pack.add({
  "https://github.com/vinnymeller/swagger-preview.nvim",
})

require("swagger-preview").setup({
  port = 6969,
  host = "127.0.0.1",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(event)
    vim.keymap.set("n", "<leader>cp", "<cmd>SwaggerPreviewToggle<cr>", {
      buffer = event.buf,
      desc = "Toggle Swagger Preview",
    })
  end,
})
