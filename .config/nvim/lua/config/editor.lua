-- Project `.editorconfig` may set `auto_format = false` to skip conform.
require("editorconfig").properties.auto_format = function(bufnr, val)
  vim.b[bufnr].disable_autoformat = val == "false"
end
