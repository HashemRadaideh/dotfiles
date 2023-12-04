---@diagnostic disable-next-line: undefined-global
local screen = screen
local awful  = require('awful')
local wibox  = require('wibox')
local gears  = require('gears')

local function getRandPic(directory)
  local lfs   = require("lfs")

  local files = {}
  local function exploreDirectory(dir)
    for file in lfs.dir(dir) do
      if file ~= "." and file ~= ".." then
        local filePath = dir .. '/' .. file
        local attr = lfs.attributes(filePath)
        if attr.mode == 'file' then
          table.insert(files, filePath)
        elseif attr.mode == 'directory' then
          exploreDirectory(filePath)
        end
      end
    end
  end
  exploreDirectory(directory)

  local index = math.random(#files)
  return files[index]
end

local wallpaper = getRandPic(os.getenv("HOME") .. "/Pictures/wallpapers")

screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      {
        image                 = wallpaper,
        resize                = true,
        upscale               = true,
        downscale             = true,
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        widget                = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled  = false,
      widget = wibox.container.background,
    }
  }
end)

screen.connect_signal("request::desktop_decoration", function(s)
  s.Bartoggle = wibox {
    screen  = s,
    visible = true,
    ontop   = true,
    bg      = "#000000",
    x       = s.geometry.x,
    y       = 0,
    width   = s.geometry.width,
    height  = 1,
    stretch = true,
  }

  s.Bar.hide = gears.timer({ timeout = 5 })

  s.Bartoggle:connect_signal('mouse::enter', function(self)
    s.Bar.visible = true
    s.Bar.hover = true
    s.Bar.hide:stop()
  end)

  s.Bartoggle:connect_signal('mouse::leave', function(self)
    s.Bar.hover = false

    s.Bar.hide:connect_signal("timeout", function()
      if not s.Bar.hover then
        s.Bar.visible = not Autohide
      end
      s.Bar.hide:stop()
    end)

    s.Bar.hide:start()
  end)

  s.Keyboard = wibox {
    screen  = s,
    visible = true,
    ontop   = true,
    bg      = "#000000",
    x       = s.geometry.x,
    y       = s.geometry.height - 1,
    width   = s.geometry.width,
    height  = 1,
    stretch = true,
  }

  s.Keyboard:connect_signal('mouse::enter', function(self)
    local _, _, status = os.execute('virtkey')
    if status == 1 then
      awful.util.spawn([[corekeyboard]])
    end
  end)
end)
