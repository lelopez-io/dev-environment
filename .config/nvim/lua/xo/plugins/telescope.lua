return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            pickers = {
                live_grep = {
                    file_ignore_patterns = { "node_modules", ".git", ".venv" },
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                },
                find_files = {
                    file_ignore_patterns = { "node_modules", ".git", ".venv" },
                    hidden = true,
                },
            },
            extensions = {
                "fzf",
            },
        })
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({
                search = vim.fn.input("Grep > "),
                additional_args = { "--hidden" },
            })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
}
