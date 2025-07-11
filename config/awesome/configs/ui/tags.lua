local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
  })
  awful.layout.suit.tile.left.mirror = true
end)

Tags = {
  -- "", "", "", "", "", "", "", "", "ﭮ", "",
  -- "", "", "", "", "", "", "", "", "", "",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  -- "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ",
  -- ">_<", "o_O", "~_~", "T-T", "^_^", "._.", ":3", ":')", ":D", "?_?",
}

local function switch(case)
  return function(codetable)
    local f
    f = codetable[case] or codetable.default
    if f then
      if type(f) == "function" then
        return f(case)
      else
        error("case " .. tostring(case) .. " not a function")
      end
    end
  end
end

function Create_tags(s)
  for i, _ in ipairs(Tags) do
    switch(i)({
      [1] = function()
        awful.tag({ Tags[1] }, s, awful.layout.layouts[1])
      end,
      [2] = function()
        awful.tag.add(Tags[2], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [3] = function()
        awful.tag.add(Tags[3], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [4] = function()
        awful.tag.add(Tags[4], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [5] = function()
        awful.tag.add(Tags[5], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [6] = function()
        awful.tag.add(Tags[6], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [7] = function()
        awful.tag.add(Tags[7], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [8] = function()
        awful.tag.add(Tags[8], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [9] = function()
        awful.tag.add(Tags[9], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      [10] = function()
        awful.tag.add(Tags[10], {
          layout = awful.layout.layouts[1],
          screen = s,
        })
      end,
      default = function()
        awful.tag.add("", {
          layout = awful.layout.layouts[-1],
          screen = s,
        })
      end,
    })
  end
end
