local terminal = "com.superlogical.terminal"

local M = {}

--- @param ctx rex.Context
function M.cwd(ctx)
  local pwd = rex.block.call(terminal, "pwd", { block_id = ctx.block_id })
  if pwd and pwd.pwd then
    return (pwd.pwd:gsub("^file://[^/]*", ""))
  end
  local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id })
  return proc and proc.foreground and proc.foreground.cwd
end

function M.create_float(window_id, cwd, command)
  local layer, err = rex.session.new_layer({
    window_id = window_id,
    bounds = { 0.05, 0.05, 0.9, 0.9 },
    focus = true,
    layout = rex.layout.block({
      flavor = terminal .. ".shell",
      options = { cwd = cwd, command = command },
    }),
  })
  if err ~= nil then
    error(err, 0)
  end
  return layer
end

---@param cwd string
---@param command? string[] Program and its arguments.
---@return table session
function M.create_session(cwd, command)
  local session, err = rex.call("session.create", {
    initial_windows = {
      {
        layout = rex.layout.block({
          flavor = terminal .. ".shell",
          options = { cwd = cwd, command = command },
        }),
      },
    },
  })
  if not session then
    error(err, 0)
  end
  return session
end

return M
