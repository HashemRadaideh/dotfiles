local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xrandr = require('ui.desktop.xrandr')

local xmin, ymin, spacing = 60, 60, 20
local bg = beautiful.bg_normal

local wibox_tree = {
  name = "root",
  width = 400,
  height = 400,
  spacing = 10,
  bg = "#ebebeb",
  forced_num_cols = 2,
  forced_num_rows = 2,
  {
    name = "exit",
    width = 400,
    height = 400,
    spacing = 10,
    bg = "#444444",
    forced_num_cols = 3,
    forced_num_rows = 2,
    row = 2, col = 2,
    image = os.getenv("HOME") .. "/.icons/door_exit.png",
    {
      row = 1, col = 1,
      image = os.getenv("HOME") .. "/.icons/power-logoff.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/at-exit.sh",
          function(stdout) end)
      end
    },
    {
      row = 1, col = 2,
      image = os.getenv("HOME") .. "/.icons/power-shutdown.png",
      callback = function() awful.spawn.easy_async("/usr/bin/sudo /sbin/shutdown -h now",
          function(stdout) end)
      end
    },
    {
      row = 1, col = 3,
      image = os.getenv("HOME") .. "/.icons/power-restart.png",
      callback = function() awful.spawn.easy_async("/usr/bin/sudo /sbin/reboot",
          function(stdout) end)
      end
    },
    {
      row = 2, col = 1,
      image = os.getenv("HOME") .. "/.icons/power-hibernate.png",
      callback = function() awful.spawn.easy_async("systemctl hibernate",
          function(stdout) end)
      end
    },
    {
      row = 2, col = 2,
      image = os.getenv("HOME") .. "/.icons/power-sleep.png",
      callback = function() awful.spawn.easy_async("systemctl suspend",
          function(stdout) end)
      end
    },
    {
      row = 2, col = 3,
      image = os.getenv("HOME") .. "/.icons/power-lock.png",
      callback = function() awful.spawn.easy_async("/usr/bin/slock",
          function(stdout) end)
      end
    }
  },
  {
    name = "apps",
    width = 400,
    height = 400,
    spacing = 10,
    bg = "#444444",
    forced_num_cols = 3,
    forced_num_rows = 2,
    row = 1, col = 2,
    image = os.getenv("HOME") .. "/.icons/my_apps.png",
    {
      row = 1, col = 1,
      image = os.getenv("HOME") .. "/.icons/terminal.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/urxvt.sh",
          function(stdout) end)
      end
    },
    {
      row = 1, col = 2,
      image = os.getenv("HOME") .. "/.icons/emacs.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/emacs.sh",
          function(stdout) end)
      end
    },
    {
      row = 1, col = 3,
      image = os.getenv("HOME") .. "/.icons/qutebrowser.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/qutebrowser",
          function(stdout) end)
      end
    },
    {
      row = 2, col = 1,
      image = os.getenv("HOME") .. "/.icons/styluslab-write.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/usr/src/Write/Write",
          function(stdout) end)
      end
    },
    {
      row = 2, col = 2,
      image = os.getenv("HOME") .. "/.icons/xournal.png",
      callback = function() awful.spawn.easy_async("/usr/bin/xournal", function(stdout) end) end
    },
    {
      row = 2, col = 3,
      image = os.getenv("HOME") .. "/.icons/firefox.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/firefox-esr",
          function(stdout) end)
      end
    },
  },
  {
    name = "awesome",
    width = 400,
    height = 400,
    spacing = 10,
    bg = "#444444",
    forced_num_cols = 2,
    forced_num_rows = 2,
    row = 1, col = 1,
    image = os.getenv("HOME") .. "/.icons/awesome.png",
    {
      row = 1, col = 1,
      image = os.getenv("HOME") .. "/.icons/screenshot.png",
      callback = function() awful.spawn.easy_async(os.getenv("HOME") .. "/bin/print.sh",
          function(stdout) end)
      end
    },
    {
      row = 1, col = 2,
      image = os.getenv("HOME") .. "/.icons/screen_resolution.png",
      callback = xrandr.xrandr
    }
  }
}


local function find_space(wibox_list, wibox_name, xmin, ymin, spacing)
  local xmax, ymax = xmin, ymin

  for _, wb in pairs(wibox_list) do
    if wb.visible then
      if xmax < (wb.x + wb.width) then
        xmax = wb.x + wb.width
      end
      if ymax < (wb.y + wb.height) then
        ymax = wb.y + wb.height
      end
    end
  end

  xmax = xmax + spacing
  ymax = ymax + spacing

  local s = awful.screen.focused()

  local xrest = s.geometry.width - xmax
  local yrest = s.geometry.height - ymax

  if xrest > yrest then
    if wibox_list[wibox_name].width < xrest then
      return { x = xmax, y = ymin, hide = false }
    elseif wibox_list[wibox_name].height < yrest then
      return { x = xmin, y = ymax, hide = false }
    else
      return { x = xmin, y = ymin, hide = true }
    end
  else
    if wibox_list[wibox_name].height < yrest then
      return { x = xmin, y = ymax, hide = false }
    elseif wibox_list[wibox_name].width < xrest then
      return { x = xmax, y = ymin, hide = false }
    else
      return { x = xmin, y = ymin, hide = true }
    end
  end
end

local function set_callback(mywidget, wibox_tree, wibox_list)
  if wibox_tree.callback ~= nil then
    -- If a callback is specified, apply it and remove all wiboxes.
    mywidget:buttons(awful.button({}, 1, function()
      for _, wb in pairs(wibox_list) do
        wb.visible = false
      end
      wibox_tree.callback()
    end))
  else
    -- If no callback specified, assume this is the button linked to the wibox itself.
    mywidget:buttons(awful.button({}, 1, function()
      if wibox_list[wibox_tree.name].visible == true then
        wibox_list[wibox_tree.name].visible = false
      else
        local space = find_space(wibox_list, wibox_tree.name,
          xmin, ymin, spacing)

        wibox_list[wibox_tree.name].x = space.x
        wibox_list[wibox_tree.name].y = space.y

        if hide == true then
          for _, wb in pairs(wibox_list) do
            wb.visible = false
          end
        end

        wibox_list[wibox_tree.name].visible = true
      end
    end))
  end
end

local function make_wibox_list(wibox_tree, xmin, ymin, bg, wibox_list)
  -- Create wibox if there exists a name.
  if wibox_tree.name ~= nil then
    wibox_list[wibox_tree.name] = wibox {
      x = wibox_tree.x or xmin,
      y = wibox_tree.y or ymin,
      width = wibox_tree.width * wibox_tree.forced_num_cols +
          (wibox_tree.spacing or 0) * (wibox_tree.forced_num_cols - 1),
      height = wibox_tree.height * wibox_tree.forced_num_rows +
          (wibox_tree.spacing or 0) * (wibox_tree.forced_num_rows - 1),
      ontop = wibox_tree.ontop or true,
      bg = wibox_tree.bg or bg
    }

    wibox_list[wibox_tree.name]:setup {
      forced_num_cols = wibox_tree.forced_num_cols,
      forced_num_rows = wibox_tree.forced_num_rows,
      spacing = wibox_tree.spacing or 0,
      homogeneous = true,
      expand = true,
      layout = wibox.layout.grid
    }
  end

  -- Recursively make wiboxes.
  for _, wibox_tree_up in ipairs(wibox_tree) do
    local mywidget = make_wibox_list(wibox_tree_up, xmin, ymin, bg, wibox_list)

    if mywidget ~= nil then
      wibox_list[wibox_tree.name].widget:add_widget_at(mywidget,
        wibox_tree_up.row,
        wibox_tree_up.col,
        1, 1)
    end
  end

  -- If there is an image or a text then create a button.
  if wibox_tree.image ~= nil then
    local mywidget = wibox.widget.imagebox()
    mywidget:set_image(wibox_tree.image)
    set_callback(mywidget, wibox_tree, wibox_list)
    return mywidget
  elseif wibox_tree.text ~= nil then
    local mywidget = wibox.widget {
      markup = wibox_tree.text,
      align  = "center",
      valign = "center",
      widget = wibox.widget.textbox
    }

    if wibox_tree.bgimage ~= nil then
      return wibox.widget {
        mywidget,
        bgimage = wibox_tree.bgimage,
        widget = wibox.container.background
      }
    elseif wibox_tree.bg ~= nil then
      return wibox.widget {
        mywidget,
        bg = wibox_tree.bg,
        widget = wibox.container.background
      }
    else
      return wibox.widget {
        mywidget,
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background
      }
    end
  else
    return wibox_tree.name
  end
end

local wibox_list = {}

awful.spawn.easy_async(make_wibox_list(wibox_tree, xmin, ymin, bg, wibox_list), function(stdout) end)

local function toggle()
  local is_one_visible = false

  for _, wb in pairs(wibox_list) do
    if wb.visible == true then
      is_one_visible = true
      break
    end
  end

  -- If one wibox is visible, assume we want to close them all,
  -- without opening the root one, otherwise toggle the root one.
  if is_one_visible then
    for _, wb in pairs(wibox_list) do
      wb.visible = false
    end
  else
    wibox_list["root"].visible = wibox_list["root"].visible == false
  end
end

return {
  toggle = toggle
}
