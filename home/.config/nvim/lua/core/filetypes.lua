vim.filetype.add({
    pattern = {
        [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
        ["%.env"] = "dotenv",
        ["%.env%.[%w_.-]+"] = "dotenv",
    },
})
