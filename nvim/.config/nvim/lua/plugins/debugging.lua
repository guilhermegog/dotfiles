return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_py = require("dap-python")
		dap_py.setup("~/.virtualenvs/debugpy/bin/python3.12")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.open()
		end

		vim.keymap.set("n", "<leader>df", dap_py.test_class, {})
		vim.keymap.set("n", "<leader>ds", dap_py.debug_selection, {})
		vim.keymap.set("n", "<leader>dn", dap_py.test_method, {})
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
	end,
}
