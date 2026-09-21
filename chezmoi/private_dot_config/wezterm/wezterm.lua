local wezterm = require "wezterm"
local config = wezterm.config_builder()
local action = wezterm.action
local mux = wezterm.mux
 
config.font = wezterm.font {
  family = 'JetBrains Mono',
  weight = 'Medium',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}
config.font_size = 30.0
config.line_height = 1.0

config.window_padding = { left = '0.5cell', right = '0.5cell', top = '0.5cell', bottom = '0.5cell' }
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 1

config.window_decorations = 'RESIZE | INTEGRATED_BUTTONS'

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = action.OpenLinkAtMouseCursor,
  },
}

config.keys = {
  { key = 'd', mods = 'CMD|SHIFT', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'k', mods = 'CMD', action = action.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'w', mods = 'CMD', action = action.CloseCurrentPane { confirm = false } },
  { key = 'w', mods = 'CMD|SHIFT', action = action.CloseCurrentTab { confirm = false } },
  { key = 'LeftArrow', mods = 'CMD', action = action.SendKey { key = 'Home' } },
  { key = 'RightArrow', mods = 'CMD', action = action.SendKey { key = 'End' } },
  { key = 'LeftArrow', mods = 'OPT', action = action.SendKey { key = 'b', mods = 'ALT' } },
  { key = 'RightArrow', mods = 'OPT', action = action.SendKey { key = 'f', mods = 'ALT' } },
  { key = 'p', mods = 'CMD|SHIFT', action = action.ActivateCommandPalette },
}

config.color_scheme = "Guezwhoz"

local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
local bg = scheme and scheme.background or '#000000'

config.tab_max_width = 60
config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Medium' },
  font_size = 12.0,
  active_titlebar_bg = bg,
  inactive_titlebar_bg = bg,
}

local MAX_TAB_TITLE = 50

wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  local title = pane.title
  if cwd then
    local path = cwd.file_path
    local home = os.getenv('HOME')
    if home and path:sub(1, #home) == home then
      path = '~' .. path:sub(#home + 1)
    end
    if #path > MAX_TAB_TITLE then
      path = '...' .. path:sub(#path - MAX_TAB_TITLE + 4)
    end
    title = path
  end

  return {
    { Text = ' ' .. title .. ' ' },
  }
end)

wezterm.on("gui-startup", function(cmd)
  -- Pick the active screen to maximize into, there are also other options, see the docs.
  local active = wezterm.gui.screens().active

  -- Set the window coords on spawn.
  local tab, pane, window = mux.spawn_window(cmd or {
    x = active.x,
    y = active.y,
    width = active.width,
    height = active.height,
  })

  -- You probably don't need both, but you can also set the positions after spawn.
  window:gui_window():set_position(active.x, active.y)
  window:gui_window():set_inner_size(active.width, active.height)
end)

return config