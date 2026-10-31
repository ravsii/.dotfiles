---@meta

--- LuaCATS type definitions for the Rex Lua API.
---
--- This file is annotations only: Rex never loads it and nothing in it runs.
--- With lua-language-server it provides completion, hover docs, and type
--- checking for `rex` in init.lua and in scripts run with `rex do`.
---
--- Reference: https://www.superlogical.com/rex/docs/reference/lua
---
--- Where each function works is noted in its description: "config" is
--- ~/.config/rex/init.lua, "script" is a file run with `rex do`.

-- Contexts, events, and results ------------------------------------------------

--- Passed to an action's `run`, a key-bound function, and event handlers.
---@class rex.Context
---@field session_id? string The session the action applies to
---@field block_id? string The block the action applies to, usually the focused one
---@field client_id? string The client that asked for the action
---@field origin? "key"|"palette"|"cli"|"api"|"script"|"timer" How the action was run
---@field server? string The server the call goes to

--- Passed to a function bound to a key with `rex.bind(key, fn)`.
---@class rex.KeyEvent
---@field keybinding string The key that was pressed
---@field prefix? string[] The keys pressed before it, when it ends a sequence

--- A key, with modifiers, optionally in a mode and optionally a sequence.
--- Examples: `"cmd+d"`, `"shift+cmd+o"`, `"ctrl+b>c"`, `"resize/left"`.
---@alias rex.Key string

---@alias rex.LogLevel "debug"|"info"|"warn"|"error"

--- What `rex.exec` returns, and what a process handle's `wait` returns.
---@class rex.ExecResult
---@field code integer Exit status, or -1 when a signal ended the command
---@field signal? string The signal that ended it, such as `"SIGTERM"`
---@field stdout string
---@field stderr string
---@field timed_out boolean
---@field ok boolean True when `code` is 0 and the command didn't time out

--- Options for `rex.exec`.
---@class rex.ExecOpts
---@field cwd? string Working directory
---@field env? table<string, string|false> Variables to set, or `false` to remove one
---@field clear_env? boolean Start from an empty environment
---@field stdin? string Text written to the command's standard input
---@field timeout? number Seconds until the command is sent SIGTERM
---@field stdout? false Discard the stream
---@field stderr? false Discard the stream
---@field text? boolean Keep `\r\n` in the output on Windows

--- Options for `rex.exec.start`, which adds streaming and detaching.
---@class rex.ExecStartOpts
---@field cwd? string
---@field env? table<string, string|false>
---@field clear_env? boolean
---@field stdin? true Keep standard input open for `h:write`
---@field stdout? fun(chunk: string) Called with each piece of output as it arrives
---@field stderr? fun(chunk: string) Called with each piece of output as it arrives
---@field timeout? number
---@field detach? boolean Let the command outlive the work that started it
---@field text? boolean

--- A running command returned by `rex.exec.start`.
---@class rex.Process
---@field pid integer
---@field wait fun(self: rex.Process, seconds?: number): rex.ExecResult? Returns nil on timeout
---@field write fun(self: rex.Process, data: string): boolean
---@field close_stdin fun(self: rex.Process)
---@field kill fun(self: rex.Process, signal?: string|integer)
---@field running fun(self: rex.Process): boolean

--- Returned by `rex.after` and `rex.every`.
---@class rex.Timer
---@field cancel fun(self: rex.Timer) Stop the timer
---@field active fun(self: rex.Timer): boolean

-- Layouts ----------------------------------------------------------------------

--- Options for a terminal block.
---@class rex.BlockOptions
---@field command? string[] The program to run and its arguments
---@field shell? string The shell to use, or `"none"` to run `command` directly
---@field cwd? string Working directory
---@field initial_input? string Text typed into the terminal once it starts
---@field exit? { on_completion?: boolean } Keep the terminal open after its program exits

--- One block in a layout.
---@class rex.BlockSpec
---@field flavor? string What to create, such as `"com.superlogical.terminal.shell"`
---@field options? rex.BlockOptions
---@field label? string

--- A node in a layout: a block, or a split of two layouts.
--- `{ block = rex.BlockSpec }` or
--- `{ split = { direction = "right"|"down"|..., before = node, after = node, ratio = number } }`
---@class rex.LayoutNode
---@field block? rex.BlockSpec
---@field split? table

-- Bindings, actions, modes -----------------------------------------------------

--- One key binding, as returned by `rex.bindings()`.
---@class rex.Binding
---@field key string The key or sequence, without its mode
---@field mode? string
---@field action? string Nil for a function binding
---@field fn? function Nil for an action binding
---@field args? table
---@field source string Where it was bound, such as `init.lua:3`

--- One key mode, as returned by `rex.modes()`.
---@class rex.Mode
---@field name string
---@field exclusive boolean
---@field source string

--- The table passed to `rex.action{ ... }`.
---@class rex.ActionSpec
---@field name string Lowercase letters, digits, and underscores; no dot
---@field title string Shown in the command palette
---@field run fun(ctx: rex.Context, args: table): any
---@field description? string
---@field category? string Defaults to "Actions"
---@field keywords? string
---@field args? table Argument types, or a JSON Schema
---@field repeats? boolean Run again while the key is held

--- The table passed to `rex.host{ ... }`.
---@class rex.HostSpec
---@field label string
---@field endpoints? string[]
---@field endpoint? string
---@field id? string
---@field icon? string

-- The API ----------------------------------------------------------------------

--- The Rex Lua API. Rex only adds to the global `rex` table.
---@class rex.Api
rex = {}

--- Call another server's API. See `rex.servers()` and `rex.server(label)`.
---@class rex.Server
---@field session rex.SessionApi
---@field block table `rex.block`, sending its calls to the other server
---@field call fun(method: string, args?: table): table|nil, string?

--- Key bindings ----------------------------------------------------------------

--- Binds a key to an action, optionally with that action's arguments.
---@param key rex.Key
---@param action string
---@param args? table
---@overload fun(key: rex.Key, fn: fun(ctx: rex.Context, ev: rex.KeyEvent): boolean?): nil
function rex.bind(key, action, args) end

--- Removes the bindings of a key, from this file and the client's defaults.
---@param key rex.Key
---@param target? string|fun(ctx: rex.Context, ev: rex.KeyEvent): boolean? Limit to this action or function
---@return integer removed How many of this file's bindings were removed
function rex.unbind(key, target) end

--- Declares a key mode and sets its options.
---@param name string
---@param options? { exclusive?: boolean } Defaults to `{ exclusive = false }`
function rex.mode(name, options) end

--- Every binding this file and the files it requires made so far.
---@param filter? { key?: string, mode?: string, action?: string }
---@return rex.Binding[]
function rex.bindings(filter) end

--- Every mode declared or bound so far.
---@return rex.Mode[]
function rex.modes() end

--- Actions ---------------------------------------------------------------------

--- Defines a custom action, runnable by name from a key, the palette, or `rex do`.
---@param spec rex.ActionSpec
function rex.action(spec) end

--- Runs an action and returns its result.
--- In the config file, only that file's own actions can be invoked.
---@param name string
---@param args? table
---@return any result
---@return string? err
function rex.invoke(name, args) end

--- The client that ran the action.
---@class rex.ClientApi
rex.client = {}

--- Asks the client that ran the action to perform one of its own actions.
---@param name string Such as `"pane.zoom"` or `"client.sidebar.toggle"`
---@param args? table
function rex.client.queue(name, args) end

--- Calling Rex -----------------------------------------------------------------

--- Calls any server method by its full name, such as `"session.list"`.
---@param method string
---@param args? table
---@return table|nil result
---@return string? err
function rex.call(method, args) end

--- The session methods. `session_id` defaults to the action's own session.
---@class rex.SessionApi
rex.session = {}

--- Get the session's windows, their layouts, and their blocks.
---@param args? table
---@return table|nil result
---@return string? err
function rex.session.view(args) end

--- List every block and whether it is placed or detached.
---@param args? table
---@return table|nil result
---@return string? err
function rex.session.list_blocks(args) end

--- List the clients attached to the session.
---@param args? table
---@return table|nil result
---@return string? err
function rex.session.list_clients(args) end

--- Get a block's placement and the methods it offers.
---@param args table `{ block_id = string }`
---@return table|nil result
---@return string? err
function rex.session.describe_block(args) end

--- Create a window from a layout. It becomes the active window by default.
---@param args table `{ layout = rex.LayoutNode, window_label? = string, focus? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.new_window(args) end

--- Create a split beside an existing block.
---@param args table `{ layout = rex.LayoutNode, direction, side?, ratio?, anchor_id?, focus? }`
---@return table|nil result
---@return string? err
function rex.session.new_split(args) end

--- Create a block without placing it in a layout.
---@param args table `{ flavor = string, options? = rex.BlockOptions, label? = string }`
---@return table|nil result
---@return string? err
function rex.session.new_block(args) end

--- Create a floating layer in a window.
---@param args table `{ layout = rex.LayoutNode, bounds = table, focus? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.new_layer(args) end

--- Close a window and every block in it.
---@param args? table `{ window_id? = string }`
---@return table|nil result
---@return string? err
function rex.session.close_window(args) end

--- Close a floating layer and every block in it.
---@param args table `{ layer_id = string }`
---@return table|nil result
---@return string? err
function rex.session.close_layer(args) end

--- Move a block into a new split beside another.
---@param args table `{ block_id, anchor_block_id, direction?, side?, ratio? }`
---@return table|nil result
---@return string? err
function rex.session.move_block(args) end

--- Exchange the positions of two blocks.
---@param args table `{ block_id, other_block_id }`
---@return table|nil result
---@return string? err
function rex.session.swap_blocks(args) end

--- Remove a block from its layout without closing it.
---@param args table `{ block_id = string }`
---@return table|nil result
---@return string? err
function rex.session.detach_block(args) end

--- Move a tiled block into a new floating layer.
---@param args table `{ block_id, bounds }`
---@return table|nil result
---@return string? err
function rex.session.float_block(args) end

--- Toggle or set whether a block fills its window.
---@param args? table `{ block_id?, window_id?, zoom? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.zoom_block(args) end

--- Move the border between two blocks.
---@param args table `{ before_block_id, after_block_id, direction, ratio }`
---@return table|nil result
---@return string? err
function rex.session.resize_pane(args) end

--- Move or resize a floating layer.
---@param args table `{ layer_id, bounds }`
---@return table|nil result
---@return string? err
function rex.session.resize_layer(args) end

--- Move a floating layer to the front, or just above another one.
---@param args table `{ layer_id, relative_layer_id? }`
---@return table|nil result
---@return string? err
function rex.session.raise_layer(args) end

--- Move a floating layer behind another one.
---@param args table `{ layer_id, relative_layer_id? }`
---@return table|nil result
---@return string? err
function rex.session.lower_layer(args) end

--- Move a window in the tab order.
---@param args table `{ window_id, before_window_id? }`
---@return table|nil result
---@return string? err
function rex.session.move_window(args) end

--- Focus a block, and its window if it isn't the active one.
---@param args table `{ block_id = string }`
---@return table|nil result
---@return string? err
function rex.session.focus_block(args) end

--- Make a window the active window.
---@param args table `{ window_id = string }`
---@return table|nil result
---@return string? err
function rex.session.focus_window(args) end

--- Focus the nearest block in a direction.
---@param args table `{ direction = "left"|"right"|"up"|"down", wrap? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.focus_direction(args) end

---@param args? table `{ wrap? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.focus_next_pane(args) end

---@param args? table `{ wrap? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.focus_previous_pane(args) end

---@param args? table `{ wrap? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.focus_next_window(args) end

---@param args? table `{ wrap? = boolean }`
---@return table|nil result
---@return string? err
function rex.session.focus_previous_window(args) end

--- Set the session's label.
---@param args table `{ label? = string }` Nil removes the label
---@return table|nil result
---@return string? err
function rex.session.set_label(args) end

--- Set a window's label.
---@param args table `{ window_id = string, label? = string }`
---@return table|nil result
---@return string? err
function rex.session.set_window_label(args) end

--- Set a block's label.
---@param args table `{ block_id = string, label? = string }`
---@return table|nil result
---@return string? err
function rex.session.set_block_label(args) end

--- Change which session a script hears events from.
---@param args table `{ session_id = string }`
---@return table|nil result
---@return string? err
function rex.session.attach(args) end

--- Detach a script's connection from a session.
---@param args? table
---@return table|nil result
---@return string? err
function rex.session.detach(args) end

--- Describe the methods the session accepts and its blocks provide.
---@param args? table
---@return table|nil result
---@return string? err
function rex.session.help(args) end

--- Blocks ----------------------------------------------------------------------

--- Calls methods on a block.
---@class rex.BlockApi
rex.block = {}

--- Call a block method. `block_id` defaults to the current block.
---@param creator string Such as `"com.superlogical.terminal"`
---@param method string Such as `"write"`, `"format"`, `"title"`, or `"pwd"`
---@param args? table
---@return table|nil result
---@return string? err
function rex.block.call(creator, method, args) end

--- Layouts ---------------------------------------------------------------------

--- Builds layout tables for `session.new_window`, `new_split`, and `new_layer`.
---@class rex.LayoutApi
rex.layout = {}

--- One block.
---@param spec rex.BlockSpec
---@return rex.LayoutNode
function rex.layout.block(spec) end

--- Two layouts split side by side.
---@param ratio number The share given to `a`, from 0 to 1
---@param a rex.LayoutNode
---@param b rex.LayoutNode
---@return rex.LayoutNode
function rex.layout.horizontal(ratio, a, b) end

--- Two layouts split one above the other.
---@param ratio number The share given to `a`, from 0 to 1
---@param a rex.LayoutNode
---@param b rex.LayoutNode
---@return rex.LayoutNode
function rex.layout.vertical(ratio, a, b) end

--- JSON ------------------------------------------------------------------------

---@class rex.JsonApi
rex.json = {}

--- Turn a Lua value into JSON text.
---@param value any
---@param opts? { indent?: boolean }
---@return string|nil text
---@return string? err
function rex.json.encode(value, opts) end

--- Turn JSON text into a Lua value. `null` becomes `nil`.
---@param text string
---@return any value
---@return string? err
function rex.json.decode(text) end

--- Commands, timers, logging ---------------------------------------------------

--- Run commands.
--- `rex.exec(argv, opts)` waits for the command to exit;
--- `rex.exec.start(argv, opts)` starts it without waiting.
---@class rex.ExecApi
---@field __call fun(self: rex.ExecApi, argv: string[], opts?: rex.ExecOpts): rex.ExecResult?, string?
---@field start fun(argv: string[], opts?: rex.ExecStartOpts): rex.Process?, string?
rex.exec = {}

--- Call `fn` once, after `seconds`. Scripts only.
---@param seconds number
---@param fn fun(ctx: rex.Context)
---@return rex.Timer
function rex.after(seconds, fn) end

--- Call `fn` every `seconds` until the timer is cancelled. Scripts only.
---@param seconds number
---@param fn fun(ctx: rex.Context)
---@return rex.Timer
function rex.every(seconds, fn) end

--- Write a log message. In a script it is printed to the terminal.
---@param message string
function rex.log(message) end

--- Write a log message at a level.
---@param level rex.LogLevel
---@param message string
function rex.log(level, message) end

--- Events (scripts only) -------------------------------------------------------

--- Call `fn` each time `event` happens.
---@param event string Such as `"block_exited"` or `"session_destroyed"`
---@param fn fun(ctx: rex.Context, ev: table)
function rex.on(event, fn) end

--- Block until `event` happens.
---@param event string
---@param filter? table|fun(ev: table, ctx: rex.Context): boolean
---@param timeout? number Seconds
---@return table|nil ev
---@return rex.Context|string ctx_or_err `"timeout"` when `timeout` seconds pass first
function rex.wait(event, filter, timeout) end

---@param seconds number
function rex.sleep(seconds) end

---@param code? integer
function rex.stop(code) end

--- Hosts and other servers -----------------------------------------------------

--- Declare another Rex server you connect to. Config file only.
---@param spec rex.HostSpec
function rex.host(spec) end

--- The labels of the other servers available to the running action or script.
---@return string[]
function rex.servers() end

--- A view of another server's API.
---@param label string
---@return rex.Server
function rex.server(label) end

--- Script values (set by `rex do`) ---------------------------------------------

--- The script's arguments.
---@type table
rex.args = {}

--- The ID of the session the script runs against.
---@type string?
rex.session_id = nil

--- The ID of the block the script runs against.
---@type string?
rex.block_id = nil
