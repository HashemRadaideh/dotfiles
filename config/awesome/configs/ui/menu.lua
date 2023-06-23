---@diagnostic disable-next-line: undefined-global
local awesome, keygrabber = awesome, keygrabber
local logout_popup = require(
  "awesome-wm-widgets.logout-popup-widget.logout-popup"
)

local awful = require('awful')
local beautiful = require('beautiful')
local capi = { keygrabber = keygrabber }
local hotkeys_popup = require('awful.hotkeys_popup')

Main_menu = awful.menu {
  theme = {
    height = 25,
    width = 250,
  },

  items = {
    {
      "Launchers",
      {
        { "rofi",  "rofi -show drun" },
        { "dmenu", "dmenu_run" },
      }
    },
    {
      "Applications",
      {
        {
          "Terminals",
          {
            { "Alacritty", "alacritty" },
            { "Kitty",     "kitty" }
          }
        },
        {
          "Browsers",
          {
            { "Brave",         "brave" },
            { "Firefox",       "firefox" },
            { "Google Chrome", "google-chrome-stable" },
          }
        },
        {
          "File managers",
          {
            { "Terminal", Terminal_file_manager },
            { "Visual",   File_manager },
          }
        },
        {
          "Editors",
          {
            { "Terminal", Terminal_editor },
            { "Visual",   Graphical_editor },
          }
        },
      },
    },
    {
      "Screenshot",
      {
        { "Whole Screen",   "screenshot" },
        { "Focused Client", "screenshot focused" },
        { "Selected Area",  "screenshot selected" },
      },
    },
    {
      "Personalize",
      {
        { "Theme",     "lxappearance" },
        { "Wallpaper", "nitrogen" },
      },
    },
    {
      "Awesome",
      {
        {
          "Hotkeys",
          function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
          end
        },
        { "Manual", Terminal_emulator .. " -e man awesome" },
        {
          "Configure",
          {
            { "Terminal editor", Terminal_editor .. " " .. awesome.conffile },
            { "Visual editor",   Graphical_editor .. " " .. awesome.conffile }
          },
        },
        { "Quit",   function() awesome.quit() end },
      },
      beautiful.awesome_icon
    },
    { "Refresh",     awesome.restart },
    { "Lock Screen", "lock" },
    {
      "Power",
      function()
        capi.keygrabber.stop()
        logout_popup.launch({
          onlock = function() awful.spawn.with_shell("lock") end,
        })
      end
    },
  },
}
