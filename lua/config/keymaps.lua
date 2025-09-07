-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 編譯 C++ 檔案，並在終端視窗內顯示編譯訊息，按 Enter 可關閉
function CompileCpp()
  vim.cmd("w")
  local filename = vim.fn.expand("%:r") -- 獲取當前檔案名稱（無副檔名）
  local cmd = string.format("g++ %s.cpp", filename)

  -- 開啟終端視窗來執行編譯
  -- vim.cmd("botright 10split")  -- 底部開一個 10 行高的 split 視窗
  -- vim.cmd("setlocal winfixheight")
  vim.cmd("split")
  vim.cmd("term " .. cmd .. " ; echo '按 Enter 鍵關閉視窗'") -- 顯示訊息並等待輸入

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(job_id, exit_code, event)
      if exit_code == 0 then -- 如果編譯成功
        vim.cmd("startinsert") -- 進入 Insert 模式
      end
    end,
  })
end

-- 在終端視窗執行 C++ 程式，按 Enter 可關閉
function RunCpp()
  vim.cmd("split") -- 開啟新視窗
  vim.cmd("term ./a.out ; echo '按 Enter 鍵關閉視窗'") -- 執行並等待輸入
  vim.cmd("startinsert") -- 進入 Insert 模式
end

-- 如果 a.out 不存在，自動編譯再執行
function SmartRunCpp()
  local output_file = "a.out"
  if vim.fn.filereadable(output_file) == 0 then
    CompileCpp()
  end
  RunCpp()
end

vim.keymap.set({ "n", "i", "v" }, "<F4>", "<ESC>:lua CompileCpp()<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<F5>", "<ESC>:lua SmartRunCpp()<CR>", { noremap = true, silent = true })
vim.keymap.set(
  { "n", "i", "v" },
  "<F6>",
  "<ESC>:read ~/cppinit/init.cpp<CR>kdd:13<CR>",
  { noremap = true, silent = true }
)
-- vim.keymap.set("n", "<F7>", "ggVGy", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<F7>", function()
  vim.cmd("normal! ggVGy")
end, { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find_files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live_grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help_tags" })
vim.keymap.set("n", "<leader>en", function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
  })
end)
