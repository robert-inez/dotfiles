local keymap = vim.keymap

keymap.set({ "n", "v" }, "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap.set({ "n", "v" }, "<leader>hv", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap.set({ "n", "v" }, "<leader>1", "<cmd>:lua require('harpoon.ui').nav_file(1)<cr>") -- navigate to file 1
keymap.set({ "n", "v" }, "<leader>2", "<cmd>:lua require('harpoon.ui').nav_file(2)<cr>") -- navigate to file 2
keymap.set({ "n", "v" }, "<leader>3", "<cmd>:lua require('harpoon.ui').nav_file(3)<cr>") -- navigate to file 3
keymap.set({ "n", "v" }, "<leader>4", "<cmd>:lua require('harpoon.ui').nav_file(4)<cr>") -- navigate to file 4
