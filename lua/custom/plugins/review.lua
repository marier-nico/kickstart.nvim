-- Code review notes on codediff views.
-- Keys live under <leader>v because <leader>r is the Run group.
return {
  'georgeguimaraes/review.nvim',
  version = '*',
  dependencies = {
    -- Captain supports codediff 4.0.6 up to (not including) 5.
    {
      'esmuellert/codediff.nvim',
      version = '^4.0.6',
      -- Single-pane diff with deleted lines shown inline; `t` toggles back to side-by-side
      opts = { diff = { layout = 'inline' } },
    },
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>vv', '<cmd>Review<cr>', desc = 'Re[V]iew working tree' },
    { '<leader>vc', '<cmd>Review commits<cr>', desc = 'Re[V]iew [C]ommits' },
    { '<leader>vb', '<cmd>Review branch<cr>', desc = 'Re[V]iew [B]ranch' },
    { '<leader>vn', ':Review note<cr>', mode = { 'n', 'v' }, desc = 'Re[V]iew: [N]ote here' },
    { '<leader>ve', '<cmd>Review edit<cr>', desc = 'Re[V]iew: [E]dit comment' },
    { '<leader>vd', '<cmd>Review delete<cr>', desc = 'Re[V]iew: [D]elete comment' },
    { '<leader>vl', '<cmd>Review list<cr>', desc = 'Re[V]iew: [L]ist comments' },
    { '<leader>vx', '<cmd>Review export<cr>', desc = 'Re[V]iew: e[X]port' },
  },
  opts = {},
  config = function(_, opts)
    require('review').setup(opts)

    -- review.nvim has no wrapping options, so patch two of its module functions.
    -- Re-check these if an update changes review.popup or review.marks.

    -- The comment input float inherits the global `nowrap`; wrap it at word boundaries.
    local popup = require 'review.popup'
    local open = popup.open
    popup.open = function(...)
      open(...)
      local win = vim.api.nvim_get_current_win() -- open() leaves the text input focused
      vim.wo[win].wrap = true
      vim.wo[win].linebreak = true
      vim.wo[win].breakindent = true
    end

    -- Saved comments render as virt_lines, which Neovim never wraps, so word-wrap a
    -- display copy of the text to fit the diff window. The stored text is untouched.
    local store = require 'review.store'
    local marks = require 'review.marks'

    local function box_width()
      local width = 100
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_win_get_config(win).relative == '' and vim.bo[buf].filetype ~= 'codediff-explorer' then
          local textoff = vim.fn.getwininfo(win)[1].textoff
          width = math.min(width, vim.api.nvim_win_get_width(win) - textoff - 5) -- 4 for "│ " and " │", 1 spare
        end
      end
      return math.max(width, 20)
    end

    local function wrap_text(text, width)
      local out = {}
      for _, para in ipairs(vim.split(text, '\n')) do
        local line = ''
        for word in para:gmatch '%S+' do
          while vim.fn.strdisplaywidth(word) > width do -- hard-break words longer than a line
            if line ~= '' then
              table.insert(out, line)
              line = ''
            end
            local n = width
            while vim.fn.strdisplaywidth(vim.fn.strcharpart(word, 0, n)) > width do
              n = n - 1
            end
            table.insert(out, vim.fn.strcharpart(word, 0, n))
            word = vim.fn.strcharpart(word, n)
          end
          if line == '' then
            line = word
          elseif vim.fn.strdisplaywidth(line .. ' ' .. word) <= width then
            line = line .. ' ' .. word
          else
            table.insert(out, line)
            line = word
          end
        end
        table.insert(out, line)
      end
      return table.concat(out, '\n')
    end

    local function with_wrapped_comments(fn)
      return function(...)
        local get_for_file = store.get_for_file
        local width = box_width()
        store.get_for_file = function(...)
          return vim.tbl_map(function(c)
            return vim.tbl_extend('force', {}, c, { text = wrap_text(c.text, width) })
          end, get_for_file(...))
        end
        local ok, err = pcall(fn, ...)
        store.get_for_file = get_for_file
        if not ok then
          error(err, 0)
        end
      end
    end

    -- render_for_buffer draws the boxes; align_buffers pads the other side to match their height
    marks.render_for_buffer = with_wrapped_comments(marks.render_for_buffer)
    marks.align_buffers = with_wrapped_comments(marks.align_buffers)

    -- Re-wrap when the window size changes
    vim.api.nvim_create_autocmd('VimResized', {
      group = vim.api.nvim_create_augroup('review-wrap', { clear = true }),
      callback = function()
        pcall(marks.refresh)
      end,
    })
  end,
}
