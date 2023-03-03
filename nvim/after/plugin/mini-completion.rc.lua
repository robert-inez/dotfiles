local status, completion = pcall(require, 'mini.completion')
if (not status) then return end

completion.setup()
