return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  lazy = 'leetcode.nvim' ~= vim.fn.argv()[1],
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim', -- required by telescope
    'MunifTanjim/nui.nvim',

    -- optional
    'nvim-treesitter/nvim-treesitter',
    'rcarriga/nvim-notify',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>ld', '<cmd>Leet desc<cr>', desc = '[L]eetcode [D]escription' },
    { '<leader>lr', '<cmd>Leet run<cr>', desc = '[L]eetcode [R]un' },
    { '<leader>ls', '<cmd>Leet submit<cr>', desc = '[L]eetcode [S]ubmit' },
    { '<leader>ll', '<cmd>Leet lang<cr>', desc = '[L]eetcode [L]anguage' },
    { '<leader>lc', '<cmd>Leet console<cr>', desc = '[L]eetcode Console' },
  },
  opts = {
    arg = 'leetcode.nvim',
    lang = 'python3',
    cn = {
      enabled = true,
      translator = false,
      translate_problems = false,
    },
    hooks = {
      ['enter'] = {
        function()
          local root = vim.fn.stdpath 'data' .. '/leetcode'
          -- check if the .git directory exists
          if vim.fn.isdirectory(root .. '/.git') == 0 then
            vim.fn.system { 'git', 'init', root }
          end
        end,
      },
    },
    injector = {
      ['golang'] = {
        before = { 'package main' },
      },
      ['python3'] = {
        before = {
          '# pyright: reportReturnType=false',
          '# pyright: reportDeprecated=false',
          '# pyright: reportWildcardImportFromLibrary=false',
          '# ruff: noqa: F403 F405 E741',
          'import copy',
          'from bisect import *',
          'from collections import *',
          'from heapq import *',
          'from itertools import *',
          'from math import *',
          'from typing import *',
        },
      },
    },
  },
}
