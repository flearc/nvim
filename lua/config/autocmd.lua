-- yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- reset cf.cpp
local templates = {
  ['cf.cpp'] = [[
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // WRITE_CODE_HERE

    return 0;
}
]],
}

vim.api.nvim_create_user_command('ResetTemplate', function(opts)
  local current_file = vim.fn.expand '%:t'
  local template = templates[current_file]

  if template then
    vim.cmd '%delete _'
    vim.fn.append(0, vim.split(template, '\n'))

    local lines = vim.fn.getline(1, '$')
    if type(lines) == 'string' then
      lines = { lines }
    end
    for i, line in ipairs(lines) do
      if line:find '// WRITE_CODE_HERE' then
        vim.api.nvim_win_set_cursor(0, { i + 1, 0 }) -- 下一行
        break
      end
    end

    vim.cmd 'write'
  else
    print('✗ No template for current file: ' .. current_file)
  end
end, { desc = 'reset current file to template' })
