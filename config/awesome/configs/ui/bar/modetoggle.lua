local beautiful = require("beautiful")
local wibox = require("wibox")

local function get_image()
  if Autohide and not Gaps and not Titles and not Sloppy then
    return beautiful.mode_zen
  elseif not Autohide and Gaps and Titles and Sloppy then
    return beautiful.mode_casual
  else
    return beautiful.mode_custom
  end
end

local mode_toggle = wibox.widget.imagebox(get_image())

mode_toggle:connect_signal("update_ui", function(self)
  self.prev = self.mode or "zen"
  if Autohide and Gaps and not Titles and not Sloppy then
    self.image = beautiful.mode_zen
    self.mode = "zen"
  elseif not Autohide and not Gaps and Titles and Sloppy then
    self.image = beautiful.mode_casual
    self.mode = "casual"
  else
    self.image = beautiful.mode_custom
    self.mode = "custom"
  end
end)

mode_toggle:connect_signal("button::press", function(self)
  if self.mode == "custom" and self.prev == "zen" then
    Autohide = false
    if Gaps then
      Gapped()
    end
    Titles = true
    Sloppy = true
  elseif self.mode == "custom" and self.prev == "casual" then
    Autohide = true
    if not Gaps then
      Gapped()
    end
    Titles = false
    Sloppy = false
  end

  Autohide = not Autohide
  for s in screen do
    if Autohide then
      s.bar.hide:start()
    else
      s.bar.visible = not Autohide
    end
  end

  Gapped()

  Titled()

  Sloppy = not Sloppy

  self:emit_signal("update_ui")
end)

return mode_toggle
