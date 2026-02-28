local g = vim.g
local o = vim.opt

g.mapleader = " "
g.maplocalleader = " "
g.t_co = 256
g.background = "dark"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.netrw_banner = 0
g.netrw_liststyle = 0
-- Give me some fenced codeblock goodness
g.markdown_fenced_languages = {
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"css",
	"lua",
	"vim",
	"bash",
}

o.laststatus = 0
o.cmdheight = 4
o.showmode = false

--NOTE: Barbecue
-- o.winbar = true
-- o.winbarpaddingleft = " "

-- o.clipboard = "unnamedplus"

o.completeopt = "menu,menuone,noselect"
o.conceallevel = 2
o.confirm = true

o.cursorline = false

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4
o.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true

o.relativenumber = true
o.numberwidth = 1
o.ruler = true

-- disable nvim intro
o.shortmess:append("sI")

o.pumblend = 10
o.pumheight = 10
o.relativenumber = true
o.scrolloff = 999
o.showtabline = 4
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
o.shiftround = true
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false
o.sidescrolloff = 8

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 300
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append("<>[]hl")

--Which-key os
o.timeout = true
o.timeoutlen = 300

if vim.fn.has("nvim-0.10") == 1 then
	o.smoothscroll = true
end

-- highlight on yank
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])
-- Vertically center document when entering insert mode
-- vim.cmd([[autocmd InsertEnter * norm zz]])
-- detect mdx file and set file type to markdown
vim.cmd([[autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx]])
--format document on save using lsp
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

--UFO
o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

--TEST:
-- o.spelllang = 'en_us'
-- o.spell = true

--NOTE: Change cursor style in insert mode
-- o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

--NOTE: Space after enter inside html element
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "html", "typescriptreact", "javascriptreact" },
-- 	callback = function()
-- 		vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<CR><Esc>O", { noremap = true, silent = true })
-- 	end,
-- })
--

-- g.android_templates_dir = "/home/notscripter/namaste-compose"
