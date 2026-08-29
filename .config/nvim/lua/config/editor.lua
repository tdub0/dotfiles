--- Support optional editorconfig parameter `auto_format` to enable or disable
--- auto formatting code with conform by default.
---
---@param bufnr integer
---@param val string
require("editorconfig").properties.auto_format = function(bufnr, val)
  vim.b[bufnr].disable_autoformat = val == "false"
end
