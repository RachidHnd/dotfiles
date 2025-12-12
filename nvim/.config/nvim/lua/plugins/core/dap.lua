return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    lazy = false,  -- Load immediately so keybindings work
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -----------------------------------------------------------
      -- FANCY BREAKPOINT ICONS (NERD FONT)
      -----------------------------------------------------------
      vim.fn.sign_define('DapBreakpoint', {
        text = '●',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '◉',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '✖',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '◆',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapStopped', {
        text = '▶',
        texthl = 'DapStopped',
        linehl = 'debugPC',
        numhl = ''
      })

      -- Custom highlight colors for breakpoints
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })  -- Red
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })     -- Green
      vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })    -- Blue
      vim.api.nvim_set_hl(0, 'debugPC', { bg = '#2d3640' })        -- Gray background

      -----------------------------------------------------------
      -- DAP UI CONFIGURATION
      -----------------------------------------------------------
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },      -- Variables
              { id = "breakpoints", size = 0.17 }, -- Breakpoints list
              { id = "stacks", size = 0.25 },      -- Call stack
              { id = "watches", size = 0.25 },     -- Watch expressions
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },         -- Debug console/REPL
              { id = "console", size = 0.5 },      -- Program output
            },
            size = 10,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
        },
        floating = {
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })

      -----------------------------------------------------------
      -- AUTO-OPEN/CLOSE DAP UI
      -----------------------------------------------------------
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()  -- Auto-close when debugging ends
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()  -- Auto-close when debugging ends
      end

      -----------------------------------------------------------
      -- VIRTUAL TEXT (INLINE VARIABLE VALUES)
      -----------------------------------------------------------
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -----------------------------------------------------------
      -- KEYBINDINGS (VSCODE STYLE)
      -----------------------------------------------------------
      vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<S-F5>', function() dap.terminate() end, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<C-S-F5>', function() dap.restart() end, { desc = 'Debug: Restart' })
      vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<S-F9>', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'Debug: Conditional Breakpoint' })
      vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<S-F11>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = 'Debug: Toggle UI' })
      vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'Debug: Toggle REPL' })
      vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug: Hover' })
      vim.keymap.set('n', '<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'Debug: Preview' })
      vim.keymap.set('n', '<leader>db', '<cmd>Telescope dap list_breakpoints<cr>', { desc = 'Debug: List Breakpoints' })
      vim.keymap.set('n', '<leader>dc', '<cmd>Telescope dap configurations<cr>', { desc = 'Debug: List Configurations' })

      -----------------------------------------------------------
      -- CODELLDB ADAPTER (C/C++)
      -----------------------------------------------------------
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
          args = {"--port", "${port}"},
        }
      }

      -----------------------------------------------------------
      -- C/C++ DEBUG CONFIGURATIONS
      -----------------------------------------------------------
      dap.configurations.c = {
        {
          name = "Launch C Program (bin/main)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.getcwd() .. '/bin/main'
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
        {
          name = "Launch C Program (custom path)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
          end,
          runInTerminal = false,
        },
      }
      
      -- C++ uses same config as C
      dap.configurations.cpp = dap.configurations.c

      -----------------------------------------------------------
      -- DEBUGPY ADAPTER (PYTHON)
      -----------------------------------------------------------
      dap.adapters.python = {
        type = 'executable',
        command = vim.fn.stdpath("data") .. '/mason/packages/debugpy/venv/bin/python',
        args = { '-m', 'debugpy.adapter' },
      }

      -----------------------------------------------------------
      -- PYTHON DEBUG CONFIGURATIONS
      -----------------------------------------------------------
      dap.configurations.python = {
        {
          name = "Launch current file",
          type = 'python',
          request = 'launch',
          program = "${file}",
          console = "integratedTerminal",
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            -- Try to find virtual environment
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python3'
            end
          end,
        },
        {
          name = "Django: Run server",
          type = 'python',
          request = 'launch',
          program = function()
            return vim.fn.getcwd() .. '/manage.py'
          end,
          args = {'runserver', '--noreload'},
          justMyCode = true,
          django = true,
          console = "integratedTerminal",
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python3'
            end
          end,
        },
        {
          name = "Attach to running process",
          type = 'python',
          request = 'attach',
          connect = {
            port = 5678,
            host = 'localhost',
          },
          pathMappings = {
            {
              localRoot = "${workspaceFolder}",
              remoteRoot = ".",
            },
          },
        },
      }

      -----------------------------------------------------------
      -- TELESCOPE DAP INTEGRATION
      -----------------------------------------------------------
      require('telescope').load_extension('dap')
    end,
  },
}
