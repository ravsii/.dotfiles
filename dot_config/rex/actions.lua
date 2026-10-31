local utils = require("utils")

---Register an action that opens a command in a floating terminal.
---@param name string Action identifier used by key bindings.
---@param title string Action title shown in the command palette.
---@param description string Action description shown in the command palette.
---@param command? string[] Program and its arguments.
local function action_float(name, title, description, command)
  rex.action({
    name = "float_" .. name,
    title = title,
    description = description,
    run = function(ctx)
      local block = rex.session.describe_block({ block_id = ctx.block_id })
      if not block then
        error("can't get block")
      end

      return utils.create_float(block.block.window_id, utils.cwd(ctx), command)
    end,
  })
end

action_float("lazygit", "Lazygit", "Open Lazygit as a popup float", { "lazygit" })
action_float("scratch", "Scratch Terminal", "Scratch terminal float")

---Register an action that opens a command in a new session.
---@param name string Action identifier suffix used by key bindings.
---@param title string Action title shown in the command palette.
---@param description string Action description shown in the command palette.
---@param command? string[] Program and its arguments.
local function action_session(name, title, description, command)
  rex.action({
    name = "session_" .. name,
    title = title,
    description = description,
    run = function(ctx)
      local cwd = utils.cwd(ctx)
      if not cwd then
        error("can't get current directory", 0)
      end
      local session = utils.create_session(cwd, command)
      rex.client.queue("session.select", { session_id = session.session_id })
      return session
    end,
  })
end

action_session("agent", "New Opencode session", "Open Opencode in a new session", { "/bin/zsh", "-lic", "agent" })

rex.action({
  name = "open_in_finder",
  title = "Open in Finder",
  description = "Open current directory in Finder",
  run = function(ctx)
    local dir = utils.cwd(ctx)
    if dir then
      rex.exec({ "open", dir })
    end
  end,
})

rex.action({
  name = "expand_float",
  title = "Expand float",
  description = "Move and expand float to center",
  run = function(ctx)
    local view, err = rex.session.view()
    if err ~= nil then
      error(err)
    end
    if not view then
      return
    end

    for _, window in ipairs(view.windows) do
      for _, layer in ipairs(window.layers) do
        for _, block in ipairs(layer.blocks) do
          if block.block_id == ctx.block_id then
            if layer.kind == "tiled" then
              return
            end

            rex.session.resize_layer({
              layer_id = layer.layer_id,
              bounds = { 0.05, 0.05, 0.9, 0.9 },
            })
          end
        end
      end
    end
  end,
})
