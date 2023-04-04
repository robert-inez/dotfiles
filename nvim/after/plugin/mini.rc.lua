local status, completion = pcall(require, 'mini.completion')
if (not status) then return end

local status2, surround = pcall(require, 'mini.surround')
if (not status2) then return end

local status3, pairs = pcall(require, 'mini.pairs')
if (not status3) then return end

local status4, bracketed = pcall(require, 'mini.bracketed')
if (not status4) then return end

pairs.setup()
surround.setup()
completion.setup()
bracketed.setup()
