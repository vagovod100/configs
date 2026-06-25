return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    -- Не показываем раздражающие ошибки в тексте.
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
      signs = false,
      underline = false,
      update_in_insert = false,
      severity_sort = true,
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,

      cmd = {
        "clangd",
        "--background-index",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--query-driver=/usr/bin/clang,/usr/bin/clang-*,/usr/bin/gcc,/usr/bin/gcc-*,/usr/bin/cc",
      },

      filetypes = { "c", "cpp", "objc", "objcpp" },

      root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        ".git",
      },
    })

	vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go" },
      root_markers = { "go.mod", ".git" },
      settings = {
        gopls = {
          analyses = {
            nilness = false,
            unusedparams = false,
          },
        },
      },
    })

    vim.lsp.enable("clangd")
	vim.lsp.enable("gopls")

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf

        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, {
            buffer = bufnr,
            silent = true,
            desc = desc,
          })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("K", vim.lsp.buf.hover, "Hover documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      end,
    })
  end,
}
