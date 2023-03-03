local status, starter = pcall(require, 'mini.starter')
if (not status) then return end

vim.g.ministarter_silence = true
starter.setup({
  autoopen = true,
  evaluate_single = true,
  items = {
    starter.sections.builtin_actions(),
    starter.sections.recent_files(5, false),
    starter.sections.recent_files(5, true),
    -- Use this if you set up 'mini.sessions'
    -- starter.sections.sessions(5, true)
  },
  footer =
  "“Don’t just think. Don’t just talk. Don’t just dream. None of that matters. The only thing that matters is that you actually do. So: DO.”  – Jocko Willink",
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Builtin actions' }),
    -- starter.gen_hook.padding(3, 2),
  },
})
