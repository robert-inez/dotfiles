require('rinez')

local has = vim.fn.has
local is_mac = has('macunix')
local is_win = has('win32')
local is_linux = has('unix')

if is_mac then
  require('macos')
end
if is_win then
  require('windows')
end
if is_linux then
  require('linux')
end
