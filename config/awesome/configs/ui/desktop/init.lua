local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

function GetRandPic(directory)
  local ok, lfs = pcall(require, "lfs")
  if not ok then
    return beautiful.default_wallpaper
  end

  local function collectWallpapers(dir, list)
    list = list or {}

    local ignore = { ["."] = true, [".."] = true, [".git"] = true }

    for file in lfs.dir(dir) do
      if not ignore[file] then
        local filePath = dir .. "/" .. file
        local mode = lfs.attributes(filePath, "mode")

        if mode == "file" then
          list[#list + 1] = filePath
        elseif mode == "directory" then
          collectWallpapers(filePath, list)
        end
      end
    end

    return list
  end

  local wallpapers = collectWallpapers(directory)
  if not wallpapers or #wallpapers == 0 then
    return beautiful.default_wallpaper
  end
  return wallpapers[math.random(#wallpapers)]
end

function Change_wallpaper(wallpaper)
  screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
      screen = s,
      widget = {
        {
          image = wallpaper,
          resize = true,
          upscale = true,
          downscale = true,
          horizontal_fit_policy = "fit",
          vertical_fit_policy = "fit",
          widget = wibox.widget.imagebox,
        },
        valign = "center",
        halign = "center",
        tiled = false,
        widget = wibox.container.background,
      },
    })
  end)
end

local function set_wallpaper()
  local wallpaper = beautiful.default_wallpaper
  if Randomize then
    wallpaper = GetRandPic(Wallpapers_path)
  end

  Change_wallpaper(wallpaper)
end

set_wallpaper()

screen.connect_signal("request::desktop_decoration", function(s)
  s.Bartoggle = wibox({
    screen = s,
    visible = true,
    ontop = true,
    bg = "#000000",
    x = s.geometry.x,
    y = s.geometry.y,
    width = s.geometry.width,
    height = 1,
    stretch = true,
  })

  s.Bartoggle:connect_signal("mouse::enter", function()
    s.Bar.visible = true
    s.Bar.hover = true
    s.Bar.hide:stop()
  end)

  s.Bartoggle:connect_signal("mouse::leave", function()
    s.Bar.hover = false

    s.Bar.hide:connect_signal("timeout", function()
      if not s.Bar.hover then
        s.Bar.visible = not Autohide
      end
      s.Bar.hide:stop()
    end)

    s.Bar.hide:start()
  end)

  -- s.Keyboard = wibox({
  --   screen = s,
  --   visible = true,
  --   ontop = true,
  --   bg = "#000000",
  --   x = s.geometry.x,
  --   y = s.geometry.y + s.geometry.height - 1,
  --   width = s.geometry.width,
  --   height = 1,
  --   stretch = true,
  -- })

  -- s.Keyboard:connect_signal("mouse::enter", function(_)
  --   -- require("naughty").notify({ message = "Entered" })

  --   -- local _, _, status = os.execute('virtkey')
  --   -- if status == 1 then
  --   --   awful.util.spawn([[corekeyboard]])
  --   -- end

  --   local g = 7.0 -- (m^2 / s) sensibility, gravity trigger

  --   local states = {
  --     {
  --       check = function(_, y)
  --         return y <= -g
  --       end,
  --       keyboard = true,
  --     },
  --     {
  --       check = function(_, y)
  --         return y >= g
  --       end,
  --       keyboard = false,
  --     },
  --     {
  --       check = function(x, _)
  --         return x >= g
  --       end,
  --       keyboard = false,
  --     },
  --     {
  --       check = function(x, _)
  --         return x <= -g
  --       end,
  --       keyboard = false,
  --     },
  --   }

  --   local x = io.open("/sys/bus/iio/devices/iio:device0/in_accel_x_raw"):read("*all")
  --   local y = io.open("/sys/bus/iio/devices/iio:device0/in_accel_y_raw"):read("*all")

  --   local current_state = nil

  --   local allowed = false

  --   for i = 1, 5 do
  --     if i == current_state then
  --       goto continue
  --     end
  --     if states[i].check(x + 0, y + 0) then
  --       current_state = i
  --       allowed = states[i].keyboard
  --       break
  --     end
  --     ::continue::
  --   end

  --   if not allowed then
  --     os.execute([[killall corekeyboard]])
  --     awful.spawn([[corekeyboard]])
  --   end
  -- end)
end)

-- screen.connect_signal("added", function()
--   for scrn in screen do
--     scrn.Bartoggle = nil
--     scrn.Keyboard = nil
--     -- if scrn.Bartoggle then
--     --   scrn.Bartoggle = nil
--     -- end
--     -- if scrn.Keyboard then
--     --   scrn.Keyboard = nil
--     -- end
--   end
-- end)

-- screen.connect_signal("removed", function()
--   for scrn in screen do
--     scrn.Bartoggle = nil
--     scrn.Keyboard = nil
--     -- if scrn.Bartoggle then
--     --   scrn.Bartoggle = nil
--     -- end
--     -- if scrn.Keyboard then
--     --   scrn.Keyboard = nil
--     -- end
--   end
-- end)
