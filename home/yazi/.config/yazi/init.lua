-- Show username and hostname in header
Header:children_add(function()
  if not ya or ya.target_family() ~= "unix" then
    return ui.Line({})
  end

  return ui.Line({
    ui.Span(ya.user_name() .. "@" .. ya.host_name()):fg("lightgreen"):bold(true),
    ui.Span(":"),
  })
end, 500, Header.LEFT)

-- Show the path of the currently hovered file in the header
function Header:cwd()
  if not self._tab or not self._tab.current then
    return ui.Line({})
  end

  local cwd = tostring(self._tab.current.cwd)
  if ya and ya.readable_path then
    cwd = ya.readable_path(cwd)
  end

  local hovered = self._tab.current.hovered
  local name = hovered and hovered.name or ""

  return ui.Line({
    ui.Span(cwd .. self:flags()):fg("blue"):bold(true),
    ui.Span("/"):fg("blue"):bold(true),
    ui.Span(tostring(name)):fg("white"):bold(true),
  })
end

-- Show symlink path in status bar
function Status:name()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line({})
  end

  local linked = ""
  if h.link_to ~= nil then
    linked = " -> " .. tostring(h.link_to)
  end
  return ui.Line(" " .. h.name .. linked)
end
