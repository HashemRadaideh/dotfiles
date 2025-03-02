local ok, lfs = pcall(require, "lfs")
if ok and Randomize then
  local function getRandPic(directory)
    local files = {}
    local function exploreDirectory(dir)
      for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." and file ~= ".git" then
          local filePath = dir .. "/" .. file
          local attr = lfs.attributes(filePath)
          if attr.mode == "file" then
            table.insert(files, filePath)
          elseif attr.mode == "directory" then
            exploreDirectory(filePath)
          end
        end
      end
    end
    exploreDirectory(directory)

    local index = math.random(#files)
    return files[index]
  end

  Wallpaper = getRandPic(os.getenv("HOME") .. "/Pictures/Wallpapers")
else
  Wallpaper = os.getenv("HOME") .. [[/Pictures/Wallpapers/Linux/Arch/1607458.png]]
end

local awful = require("awful")
local wibox = require("wibox")

screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper({
    screen = s,
    widget = {
      {
        image = Wallpaper,
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

screen.connect_signal("added", function()
  for scrn in screen do
    scrn.Bartoggle = nil
    scrn.Keyboard = nil
    -- if scrn.Bartoggle then
    --   scrn.Bartoggle = nil
    -- end
    -- if scrn.Keyboard then
    --   scrn.Keyboard = nil
    -- end
  end
end)

screen.connect_signal("removed", function()
  for scrn in screen do
    scrn.Bartoggle = nil
    scrn.Keyboard = nil
    -- if scrn.Bartoggle then
    --   scrn.Bartoggle = nil
    -- end
    -- if scrn.Keyboard then
    --   scrn.Keyboard = nil
    -- end
  end
end)
