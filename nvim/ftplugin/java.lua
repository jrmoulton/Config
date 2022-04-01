
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/jaredmoulton/Developer/java_workspaces/' .. project_name
local bundles = {
	vim.fn.glob("/Users/jaredmoulton/workspace/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.35.0.jar")
};
vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/jaredmoulton/workspace/vscode-java-test/server/*.jar"), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

	-- -Declipse.application=org.eclipse.jdt.ls.core.id1
	-- -Dosgi.bundles.defaultStartLevel=4
	-- -Declipse.product=org.eclipse.jdt.ls.core.product
	-- -Dlog.protocol=true
	-- -Dlog.level=ALL
	-- -Xms1g
	-- -Xmx2G
	-- --add-modules=ALL-SYSTEM
	-- --add-opens java.base/java.util=ALL-UNNAMED
	-- --add-opens java.base/java.lang=ALL-UNNAMED
	-- -jar $JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar
	-- -configuration config_mac
	-- -data /Users/jaredmoulton/Programming/java-binary-tree

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
	'-Xmx2G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', '/Users/jaredmoulton/Downloads/jdt-language-server-1.9.0-202201270134/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', '/Users/jaredmoulton/Downloads/jdt-language-server-1.9.0-202201270134/config_mac/',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir,
	-- '-data', '/Users/jaredmoulton/Programming/java-binary-tree',
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = Capabilities,
  autostart = true,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
	settings = {
		java = {signatureHelp = {enabled = true}, contentProvider = {preferred = 'fernflower'}}
	},

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
		bundles = bundles;
  },
  require('jdtls.setup').add_commands()
}
config['on_attach'] = function (client, bufnr)
	require "lsp_signature".on_attach({doc_lines = 1}, bufnr)
    require('jdtls').setup_dap({hotcodereplace = 'auto' })
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- go to definition
    vim.keymap.set('n', 'J', '<cmd>lua vim.lsp.buf.hover()<CR>')
    -- brind up a window to show dodumentation
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- rename the current token
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- Code actions are code suggestions maybe clippy?
    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>")
    -- format the whole document

    vim.keymap.set( 'n', '<leader>dtc', '<Cmd>lua require"jdtls".test_class()<CR>' )
    vim.keymap.set( 'n', '<leader>dn', '<Cmd>lua require"jdtls".test_nearest_method()<CR>' )
end
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
require ('dap.ext.vscode').load_launchjs()


