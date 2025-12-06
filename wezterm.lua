local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is the color scheme for the retro tab bar and other UI elements.
config.colors = {
  compose_cursor = 'orange',
  tab_bar = {
    background = '#0b0022',
    active_tab = {
      bg_color = '#2b2042',
      fg_color = 'white',
    },
    inactive_tab = {
      bg_color = '#1b1032',
      fg_color = 'white',
    },
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,
    },
    new_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',
    },
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,
    },
  },
}

config.window_background_gradient = {
  -- Can be "Vertical" or "Horizontal".  Specifies the direction
  orientation = 'Horizontal',
  colors = {
    '#262625',
    '#1a253d',
    '#262625',
  },
  -- preset = "Warm",
  -- "Linear", "Basis" and "CatmullRom" as supported.
  interpolation = 'Basis',
  blend = 'Rgb',
  -- noise = 64,
  -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
  segment_size = 11,
  segment_smoothness = 0.2,
}

-- This function styles the tabs with powerline arrows, reading colors from the config.
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
  -- The filled in variant of the > symbol
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

  -- Get the background color of the tab bar itself from the config
  local tab_bar_bg = config.colors.tab_bar.background

  -- Determine the tab's background and foreground colors based on its state
  local tab_bg
  local tab_fg
  if tab.is_active then
    tab_bg = config.colors.tab_bar.active_tab.bg_color
    tab_fg = config.colors.tab_bar.active_tab.fg_color
  elseif hover then
    tab_bg = config.colors.tab_bar.inactive_tab_hover.bg_color
    tab_fg = config.colors.tab_bar.inactive_tab_hover.fg_color
  else
    tab_bg = config.colors.tab_bar.inactive_tab.bg_color
    tab_fg = config.colors.tab_bar.inactive_tab.fg_color
  end

  local title = tab.active_pane.title

  -- This returns the formatted segments that make up the tab
  return {
    -- Left separator
    {
      background = { Color = tab_bar_bg },
      foreground = { Color = tab_bg },
      text = SOLID_LEFT_ARROW,
    },
    -- Tab title
    {
      background = { Color = tab_bg },
      foreground = { Color = tab_fg },
      text = ' ' .. title .. ' ',
    },
    -- Right separator
    {
      background = { Color = tab_bar_bg },
      foreground = { Color = tab_bg },
      text = SOLID_RIGHT_ARROW,
    },
  }
end)

-- This function shows the LEADER status in the bottom right.
wezterm.on('update-right-status', function(window, pane)
  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER'
  end
  window:set_right_status(leader)
end)


-- Your Personal Configuration Settings
config.bold_brightens_ansi_colors = true
config.cursor_blink_rate = 400
config.color_scheme = "Dracula (Official)"
config.audible_bell = "SystemBeep"
config.window_background_image_hsb = {
  brightness = 0.8,
  saturation = 0.9,
  hue = 1,
}
config.window_background_opacity = 0.99

config.font = wezterm.font({
  family = "Ubuntu Sans Mono",
  weight = "Medium",
})
config.font_size = 11

config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.line_height = 1.2
config.cell_width = 1
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_decorations = "TITLE | RESIZE"
config.initial_cols = 170
config.initial_rows = 80
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.scrollback_lines = 10000
config.default_cursor_style = "BlinkingBlock"


config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
--
-- config.font_rules = {
--   {
--     italic = true,
--     intensity = "Bold",
--     font = wezterm.font({
--       family = "Geist Mono",
--       weight = "Regular",
--       style = "Italic",
--     }),
--   },
-- }

config.leader = { key = "b", mods = "CTRL" }
config.keys = {
  { key = 'o', mods = 'LEADER', action = wezterm.action.ShowLauncher },
  { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  { key = 'r', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 'h', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = 'LeftArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Left" },
  { key = 'RightArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Right" },
  { key = 'UpArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Up" },
  { key = 'DownArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Down" },
  { key = '1', mods = 'CTRL', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CTRL', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CTRL', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CTRL', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CTRL', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'CTRL', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'CTRL', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'CTRL', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'CTRL', action = wezterm.action.ActivateTab(8) },
}

config.window_frame = {
  font = wezterm.font 'Rec Mono Casual',
  font_size = 12.0,
  inactive_titlebar_bg = '#2b2042',
  active_titlebar_bg = '#1c1c1c',
  inactive_titlebar_fg = 'cyan',
  active_titlebar_fg = 'cyan',
  inactive_titlebar_border_bottom = 'cyan',
  active_titlebar_border_bottom = 'cyan',
  button_fg = '#cccccc',
  button_bg = '#2b2042',
  button_hover_fg = '#ffffff',
  button_hover_bg = '#3b3052',
  border_left_width = '0.3cell',
  border_right_width = '0.3cell',
  border_bottom_height = '0.2cell',
  border_top_height = '0.2cell',
  border_left_color = 'cyan',
  border_right_color = 'cyan',
  border_top_color = 'cyan',
  border_bottom_color = 'cyan'
}

-- and finally, return the configuration!
return config
