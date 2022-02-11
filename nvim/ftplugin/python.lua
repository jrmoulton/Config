
require('dap-python').setup('venv/bin/python')
require('dap-python').test_runner = 'pytest'

vim.keymap.set( 'n', '<leader>dn', '<Cmd>lua require("dap-python").test_method()<CR>' )
vim.keymap.set( 'n', '<leader>dtc', '<Cmd>lua require("dap-python").test_class()<CR>' )

