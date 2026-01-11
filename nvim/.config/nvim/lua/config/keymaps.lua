
-----------------------------------------------------------------------------------------------------------------
---------------------------------        PURE GIT BLAME (INLINE & CLEAN)        ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Namespace for virtual text
local blame_ns = vim.api.nvim_create_namespace("git_blame")

-- Toggle state
local blame_enabled = false

-----------------------------------------------------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------------------------------------------------

-- Get directory of current file
local function file_dir()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return nil
  end
  return vim.fn.fnamemodify(file, ":h")
end

-- Check if directory is inside a git repository
local function is_git_repo(dir)
  local result = vim.fn.systemlist({
    "git",
    "-C",
    dir,
    "rev-parse",
    "--is-inside-work-tree",
  })
  return vim.v.shell_error == 0 and result[1] == "true"
end

-- Convert unix timestamp to relative time
local function time_ago(timestamp)
  local diff = os.time() - tonumber(timestamp)

  local minute = 60
  local hour = 60 * minute
  local day = 24 * hour
  local week = 7 * day
  local month = 30 * day
  local year = 365 * day

  if diff < hour then
    return math.floor(diff / minute) .. "m ago"
  elseif diff < day then
    return math.floor(diff / hour) .. "h ago"
  elseif diff < week then
    return math.floor(diff / day) .. "d ago"
  elseif diff < month then
    return math.floor(diff / week) .. "w ago"
  elseif diff < year then
    return math.floor(diff / month) .. "mo ago"
  else
    return math.floor(diff / year) .. "y ago"
  end
end

-----------------------------------------------------------------------------------------------------------------
-- Core Logic
-----------------------------------------------------------------------------------------------------------------

local function show_blame()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_clear_namespace(0, blame_ns, 0, -1)

  local dir = file_dir()
  if not dir or not is_git_repo(dir) then
    vim.api.nvim_buf_set_extmark(0, blame_ns, line - 1, 0, {
      virt_text = {
        { "\t\t Not a git repository", "Comment" },
      },
      virt_text_pos = "eol",
    })
    return
  end

  local output = vim.fn.systemlist({
    "git",
    "-C",
    dir,
    "blame",
    "-L",
    line .. "," .. line,
    "--porcelain",
    file,
  })

  if vim.v.shell_error ~= 0 or #output == 0 then
    return
  end

  local author, summary, author_time

  for _, l in ipairs(output) do
    if l:match("^author ") then
      author = l:gsub("author ", "")
    elseif l:match("^author%-time ") then
      author_time = l:gsub("author%-time ", "")
    elseif l:match("^summary ") then
      summary = l:gsub("summary ", "")
    end
  end

  -- Handle uncommitted lines
  if author == "Not Committed Yet" then
    vim.api.nvim_buf_set_extmark(0, blame_ns, line - 1, 0, {
      virt_text = {
        { "\t\t Not committed yet", "Comment" },
      },
      virt_text_pos = "eol",
    })
    return
  end

  if not author or not summary or not author_time then
    return
  end

  local when = time_ago(author_time)

  vim.api.nvim_buf_set_extmark(0, blame_ns, line - 1, 0, {
    virt_text = {
      {
        string.format("\t\t %s • %s • %s", author, when, summary),
        "Comment",
      },
    },
    virt_text_pos = "eol",
  })
end

-----------------------------------------------------------------------------------------------------------------
-- Toggle & Autocmd
-----------------------------------------------------------------------------------------------------------------

local function toggle_blame()
  blame_enabled = not blame_enabled
  vim.api.nvim_buf_clear_namespace(0, blame_ns, 0, -1)

  if blame_enabled then
    show_blame()
  end
end

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    if blame_enabled then
      show_blame()
    end
  end,
})

vim.keymap.set("n", "<leader>gt", toggle_blame, {
  desc = "Toggle Git Blame (current line)",
})














-----------------------------------------------------------------------------------------------------------------
---------------------------------              DAP LOGPOINT TOGGLE              ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Track logpoints per buffer and line
local logpoints = {}

Snacks.toggle
  .option("dap_logpoint", {
    name = "Logpoint",
    get = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local line = vim.fn.line(".")
      return logpoints[bufnr .. ":" .. line] == true
    end,
    set = function(val)
      local bufnr = vim.api.nvim_get_current_buf()
      local line = vim.fn.line(".")
      local key = bufnr .. ":" .. line

      if not val then
        dap.clear_breakpoints(bufnr)
        logpoints[key] = nil
        vim.notify("Logpoint removed")
        return
      end

      vim.ui.input({ prompt = "Logpoint message: " }, function(msg)
        if not msg or msg == "" then
          vim.notify("Cancelled")
          return
        end

        dap.set_breakpoint(nil, nil, msg)
        logpoints[key] = true
        vim.notify("Logpoint added: " .. msg)
      end)
    end,
  })
  :map("<leader>dL")

-----------------------------------------------------------------------------------------------------------------
---------------------------------              ADDITIONAL KEYMAPS               ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Add more custom keymaps below this line
-- Example:
-- vim.keymap.set("n", "<leader>xx", "<cmd>SomeCommand<cr>", { desc = "Description" })
