return {
  "nvim-mini/mini.files",
  version = false,
  config = function()
    require("mini.files").setup({
      options = {
        permanent_delete = true,
        use_as_default_explorer = true,
      },
      
	  windows = {
        preview = true,
        width_preview = 30,
      },
      
	  mappings = {
        close = "q",         -- Закрыть окно
        go_in = "l",         -- Войти в папку/открыть файл
        go_out = "h",        -- Выйти из папки
        show_help = "g?",    -- Показать помощь по всем маппингам
        -- Другие маппинги оставлены по умолчанию
      },
    })

    vim.api.nvim_create_user_command("Files", function()
      require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
    end, {})
  end,
}
