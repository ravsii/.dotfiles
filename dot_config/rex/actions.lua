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
---@param cwd string Working directory.
---@param command? string[] Program and its arguments.
local function action_session(name, title, description, cwd, command)
  rex.action({
    name = "session_" .. name,
    title = title,
    description = description,
    run = function()
      local session = utils.create_session(cwd, command)
      rex.client.queue("session.select", { session_id = session.session_id })
      return session
    end,
  })
end

action_session("agent", "New Opencode session", "Open Opencode in a new session", os.getenv("HOME") or "~", { "agent" })

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

-- Fractions of the window size: outer margin and offset between floats.
local cascade_margin = 0.05
local cascade_step = 0.04

rex.action({
  name = "cascade_floats",
  title = "Cascade floats",
  description = "Arrange floats in a cascade",
  run = function(ctx)
    local block, block_err = rex.session.describe_block({ block_id = ctx.block_id })
    if block_err then
      error(block_err, 0)
    end
    if not block then
      return
    end

    local view, view_err = rex.session.view()
    if view_err then
      error(view_err, 0)
    end
    if not view then
      return
    end

    for _, window in ipairs(view.windows) do
      if window.window_id == block.block.window_id then
        local layers = {}
        for _, layer in ipairs(window.layers) do
          if layer.kind == "floating" then
            table.insert(layers, layer)
          end
        end

        if #layers > 0 then
          local area = 1 - 2 * cascade_margin
          -- Reserve at least half of the cascade area for each float.
          local step = #layers > 1 and math.min(cascade_step, area / (2 * (#layers - 1))) or 0
          local size = area - (#layers - 1) * step
          for i, layer in ipairs(layers) do
            local offset = cascade_margin + (i - 1) * step
            local _, err = rex.session.resize_layer({
              layer_id = layer.layer_id,
              bounds = { offset, offset, size, size },
            })
            if err then
              error(err, 0)
            end
          end
        end
        return
      end
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
