local status, completion = pcall(require, 'mini.completion')
if not status then
  return
end

local status2, surround = pcall(require, 'mini.surround')
if not status2 then
  return
end

local status3, pairs = pcall(require, 'mini.pairs')
if not status3 then
  return
end

local status4, bracketed = pcall(require, 'mini.bracketed')
if not status4 then
  return
end

local status5, statusline = pcall(require, 'mini.statusline')
if not status5 then
  return
end

local status6, comment = pcall(require, 'mini.comment')
if not status6 then
  return
end

local status7, fuzzy = pcall(require, 'mini.fuzzy')
if not status7 then
  return
end

pairs.setup()
surround.setup()
completion.setup()
bracketed.setup()
statusline.setup()
comment.setup()
fuzzy.setup()
