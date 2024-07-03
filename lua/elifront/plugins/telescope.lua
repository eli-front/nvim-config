return {
    	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function() 
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files'})
		vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Find git files'})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ")})
		end)
	end
}
