return {
  'echasnovski/mini.notify',
  opts = function ()
    vim.notify = require("mini.notify").make_notify()
    return {}
  end
}
