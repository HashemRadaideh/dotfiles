---@diagnostic disable: different-requires
return {
  function()
    return ("%s"):format(require("schema-companion").get_current_schemas() or "none"):sub(0, 128)
  end,
  cond = function()
    return package.loaded["schema-companion"] and require("schema-companion").get_current_schemas() ~= nil
  end,
}
