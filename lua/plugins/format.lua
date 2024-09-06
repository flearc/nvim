return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  dependencies = {
    -- auto install formatters declared at formatters_by_ft option
    { 'zapling/mason-conform.nvim', config = true },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- disable format for specific languages
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      -- disable format with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt', 'golines' },
      python = { 'ruff_organize_imports', 'ruff_format' },
    },
  },
  config = function(_, opts)
    local switch_format = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local disable = vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat
      if disable then
        vim.cmd 'FormatEnable'
        vim.notify('Format enabled', vim.log.levels.INFO, { title = 'Conform' })
      else
        vim.cmd 'FormatDisable'
        vim.notify('Format disabled', vim.log.levels.INFO, { title = 'Conform' })
      end
    end
    vim.keymap.set('n', '<leader>tf', switch_format, { desc = 'Coform: [T]oggle [F]ormat' })
    -- setup
    require('conform').setup(opts)
  end,
}
