return {
  -- Automatic adjust shiftwidth and expandtab
  'tpope/vim-sleuth',

  -- Highlight comment for TODO HACK BUG etc
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Diagnostics list
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
    },
  },

  -- Noice
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
        hover = {
          -- prevent "No information available" messages
          silent = true,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  -- Search/replace in multiple files
  {
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    -- stylua: ignore
    keys = {
      { "<leader>rs", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  },

  -- Search/jump for current screen
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - gzaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - gzd'   - [S]urround [D]elete [']quotes
      -- - gzr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'msa', -- Add surrounding in Normal and Visual modes
          delete = 'msd', -- Delete surrounding
          find = 'msf', -- Find surrounding (to the right)
          find_left = 'msF', -- Find surrounding (to the left)
          highlight = 'msh', -- Highlight surrounding
          replace = 'msr', -- Replace surrounding
          update_n_lines = 'msn', -- Update `n_lines`
        },
      }
    end,
    -- Hardtime for good habit
    {
      'm4xshen/hardtime.nvim',
      dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
      opts = {},
    },

    -- Improve viewing markdown files in Neovim
    {
      'MeanderingProgrammer/render-markdown.nvim',
      main = 'render-markdown',
      opts = {},
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      ft = { 'markdown' },
    },
    {
      'mrjones2014/smart-splits.nvim',
      config = function()
        local smart_splits = require 'smart-splits'

        -- Define key mappings for resizing splits
        local keys = {
          -- resize keys
          ['<A-h>'] = smart_splits.resize_left,
          ['<A-j>'] = smart_splits.resize_down,
          ['<A-k>'] = smart_splits.resize_up,
          ['<A-l>'] = smart_splits.resize_right,
          -- move keys
          ['<C-h>'] = smart_splits.move_cursor_left,
          ['<C-j>'] = smart_splits.move_cursor_down,
          ['<C-k>'] = smart_splits.move_cursor_up,
          ['<C-l>'] = smart_splits.move_cursor_right,
          ['<C-\\>'] = smart_splits.move_cursor_previous,
          -- swap keys
          -- TODO: add keymap descriptions
          ['<leader><leader>h'] = smart_splits.swap_buf_left,
          ['<leader><leader>j'] = smart_splits.swap_buf_down,
          ['<leader><leader>k'] = smart_splits.swap_buf_up,
          ['<leader><leader>l'] = smart_splits.swap_buf_right,
        }

        -- Apply key mappings
        for key, func in pairs(keys) do
          vim.keymap.set('n', key, func)
        end

        smart_splits.setup {}
      end,
    },
    --[[
      The colorscheme I prefered do support transparency, but it can not switch using a keymap.
      So I use this plugin to switch between transparent and non-transparent.

      Usage: `:TransparentEnable` and `:TransparentDisable`
    --]]
    { 'xiyaowong/transparent.nvim' },
    -- venv
    {
      'linux-cultist/venv-selector.nvim',
      branch = 'regexp', -- Use this branch for the new version
      lazy = false,
      opts = {
        settings = {
          options = {
            notify_user_on_venv_activation = true,
            debug = true,
          },
        },
      },
      --  Call config for python files and load the cached venv automatically
      ft = 'python',
      keys = {
        { ',v', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' },
      },
    },
  },
}
