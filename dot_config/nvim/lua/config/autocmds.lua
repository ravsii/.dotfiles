-- Highlight On Yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.zig",
  desc = "Organize Zig imports with ZLS",
  callback = function(args)
    local method = "textDocument/codeAction"
    local client = vim.lsp.get_clients({ bufnr = args.buf, name = "zls", method = method })[1]
    if not client then
      return
    end

    local kind = "source.organizeImports"
    local start = { line = 0, character = 0 }
    local response = client:request_sync(method, {
      textDocument = { uri = vim.uri_from_bufnr(args.buf) },
      range = { start = start, ["end"] = start },
      context = { diagnostics = {}, only = { kind } },
    }, 1000, args.buf)

    for _, action in ipairs(response and response.result or {}) do
      if action.kind == kind and action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        break
      end
    end
  end,
})
