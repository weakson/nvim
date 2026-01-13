-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Hotfix: ft_to_lang removed in Neovim 0.10
local lang = vim.treesitter.language
if lang and lang.ft_to_lang == nil then
  lang.ft_to_lang = function(ft)
    return ft -- fallback: simply return filetype
  end
end
