vim.g.mapleader = " "

local keymap = vim.keymap -- conciseness
local api = vim.api 

-- general keymaps
keymap.set("n","<leader>nh", ":nohl<CR>") -- clear search highlights

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")  -- increment 
keymap.set("n", "<leader>-", "<C-x>")  -- decrement

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- equalize split windows
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>") 
keymap.set("n", "<leader>tn", ":tabnext<CR>") 
keymap.set("n", "<leader>tp", ":tabprev<CR>")

-- plugin keymaps
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- zen mode
keymap.set("n", "<leader>zm", ":TZMinimalist<CR>")
keymap.set("n", "<leader>za", ":TZAtaraxis<CR>")
