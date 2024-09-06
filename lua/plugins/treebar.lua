return {
  -- Browse the file system
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        filtered_items = {
          always_show = {
            '.gitignore',
            '.gitmodules',
            '.gitattributes',
          },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },

  -- Sidebar with tree-like outline of symbols
  {
    'hedyhli/outline.nvim',
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

      require('outline').setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
}
