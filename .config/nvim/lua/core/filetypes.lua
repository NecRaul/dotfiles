vim.filetype.add({
    pattern = {
        [".*/%.github/workflows/.*%.ya?ml"] = "ghaction",
        ["%.env"] = "dotenv",
        ["%.env%.[%w_.-]+"] = "dotenv",
    },
})
