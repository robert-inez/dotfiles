local status, indentscope = pcall(require, 'mini.indentscope')
if (not status) then return end

indentscope.setup()
