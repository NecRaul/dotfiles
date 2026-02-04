return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        local fzf_lua = require("fzf-lua")
        fzf_lua.setup({
            winopts = {
                border = "rounded",
                backdrop = 60,
                treesitter = {
                    enabled = false,
                    fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
                },
                preview = {
                    border = "rounded",
                    wrap = true,
                    hidden = false,
                    vertical = "down:50%",
                    horizontal = "right:50%",
                    layout = "flex",
                    title = true,
                    title_pos = "center",
                    scrollbar = "float",
                    winopts = {
                        number = true,
                        relativenumber = false,
                        cursorline = false,
                        cursorlineopt = "both",
                        cursorcolumn = false,
                        signcolumn = "no",
                        list = false,
                        foldenable = false,
                        foldmethod = "manual",
                    },
                },
                on_create = function()
                    --
                end,
            },
            keymap = {
                builtin = {
                    true, -- inherit defaults
                    ["<A-r>"] = "preview-reset",
                    ["<A-j>"] = "preview-down",
                    ["<A-k>"] = "preview-up",
                },
                fzf = {
                    true, --inherit defaults
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-u"] = "half-page-up",
                    ["alt-i"] = "beginning-of-line",
                    ["alt-a"] = "end-of-line",
                    ["alt-d"] = "unix-line-discard",
                    ["alt-s"] = "select-all",
                    ["alt-u"] = "deselect-all",
                },
            },
            actions = {
                files = {
                    -- true, -- inherit defaults
                    ["enter"] = FzfLua.actions.file_edit,
                    ["ctrl-s"] = FzfLua.actions.file_split,
                    ["ctrl-v"] = FzfLua.actions.file_vsplit,
                    ["ctrl-h"] = FzfLua.actions.toggle_hidden,
                },
            },
            fzf_opts = {
                -- options are sent as `<left>=<right>`
                -- set to `false` to remove a flag
                -- set to `true` for a no-value flag
                ["--layout"] = "reverse",
                ["--ansi"] = true,
                ["--height"] = "100%",
            },
            previewers = {
                builtin = {
                    syntax = true,
                    treesitter = {
                        enabled = true,
                    },
                    extensions = {
                        ["png"] = { "ueberzug" },
                        ["jpg"] = { "ueberzug" },
                        ["jpeg"] = { "ueberzug" },
                        ueberzug_scaler = "cover",
                    },
                },
            },
            vim.keymap.set("n", "<C-p>", function()
                local git_ok = pcall(vim.fn.system, "git rev-parse --is-inside-work-tree")
                if git_ok and vim.v.shell_error == 0 then
                    fzf_lua.git_files()
                else
                    fzf_lua.files()
                end
            end, {
                desc = "FzfLua [P]review",
            }),
            files = {
                prompt = "Files❯ ",
                cwd_prompt = false,
                no_ignore = true,
                cmd = [[ rg \
                        --files \
                        --iglob "!**/*.bak" \
                        --iglob "!**/*.db" \
                        --iglob "!**/*.exe" \
                        --iglob "!**/*.lock" \
                        --iglob "!**/*.log" \
                        --iglob "!**/*.min.js" \
                        --iglob "!**/*.o" \
                        --iglob "!**/*.rar" \
                        --iglob "!**/*.sqlite" \
                        --iglob "!**/*.sqlite3" \
                        --iglob "!**/*.stfolder" \
                        --iglob "!**/*.stversions" \
                        --iglob "!**/*.swp" \
                        --iglob "!**/*.tar.gz" \
                        --iglob "!**/*.tmp" \
                        --iglob "!**/*.zip" \
                        --iglob "!**/.cache" \
                        --iglob "!**/.git" \
                        --iglob "!**/.parcel-cache" \
                        --iglob "!**/.venv" \
                        --iglob "!**/.yarn" \
                        --iglob "!**/__pycache__" \
                        --iglob "!**/bin" \
                        --iglob "!**/build" \
                        --iglob "!**/dist" \
                        --iglob "!**/logs" \
                        --iglob "!**/node_modules" \
                        --iglob "!**/obj" \
                        --iglob "!**/out" \
                        --iglob "!**/target" \
                        --iglob "!**/tmp" \
                        --iglob "!**/vendor" \
                      ]],
            },
            git = {
                prompt = "Git Files❯ ",
                files = {
                    cmd = "git ls-files --exclude-standard",
                },
                vim.keymap.set("n", "<C-g><C-s><C-s>", fzf_lua.git_status, {
                    desc = "FzfLua [G]it [S]tatus",
                }),
                status = {
                    prompt = "Git Status❯ ",
                    cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1 -u",
                    previewer = "git_diff",
                    actions = {
                        ["l"] = { fn = FzfLua.actions.git_unstage, reload = true },
                        ["h"] = { fn = FzfLua.actions.git_stage, reload = true },
                        ["r"] = { fn = FzfLua.actions.git_reset, reload = true },
                    },
                },
                vim.keymap.set("n", "<C-g><C-d>", fzf_lua.git_diff, {
                    desc = "FzfLua [G]it [D]iff",
                }),
                diff = {
                    prompt = "Git Diff❯ ",
                    cmd = "git --no-pager diff --name-only {ref}",
                    ref = "HEAD",
                    preview = "git diff --color=always {ref} {file}",
                },
                vim.keymap.set("n", "<C-g><C-h>", fzf_lua.git_hunks, {
                    desc = "FzfLua [G]it [H]unks",
                }),
                hunks = {
                    prompt = "Git Hunks❯ ",
                    cmd = "git --no-pager diff --color=always",
                },
                vim.keymap.set("n", "<C-g><C-c>", fzf_lua.git_commits, {
                    desc = "FzfLua [G]it [C]ommits",
                }),
                commits = {
                    prompt = "Git Commits❯ ",
                    cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
                        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"]],
                    preview = "git show --color {1}",
                    actions = {
                        ["enter"] = FzfLua.actions.git_checkout,
                        -- remove `exec_silent` or set to `false` to exit after yank
                        ["ctrl-y"] = { fn = FzfLua.actions.git_yank_commit, exec_silent = true },
                    },
                },
                vim.keymap.set("n", "<C-g><C-b><C-c>", fzf_lua.git_bcommits, {
                    desc = "FzfLua [G]it [B]uffer [C]ommits",
                }),
                bcommits = {
                    prompt = "Git BCommits❯ ",
                    cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
                        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {file}]],
                    preview = "git show --color {1} -- {file}",
                    actions = {
                        ["enter"] = FzfLua.actions.git_buf_edit,
                        ["ctrl-s"] = FzfLua.actions.git_buf_split,
                        ["ctrl-v"] = FzfLua.actions.git_buf_vsplit,
                        ["ctrl-y"] = { fn = FzfLua.actions.git_yank_commit, exec_silent = true },
                    },
                },
                vim.keymap.set("n", "<C-g><C-b><C-l>", fzf_lua.git_blame, {
                    desc = "FzfLua [G]it [B][L]ame",
                }),
                blame = {
                    prompt = "Git Blame> ",
                    cmd = [[git blame --color-lines {file}]],
                    preview = "git show --color {1} -- {file}",
                    actions = {
                        ["enter"] = FzfLua.actions.git_goto_line,
                        ["ctrl-s"] = FzfLua.actions.git_buf_split,
                        ["ctrl-v"] = FzfLua.actions.git_buf_vsplit,
                        ["ctrl-t"] = FzfLua.actions.git_buf_tabedit,
                        ["ctrl-y"] = { fn = FzfLua.actions.git_yank_commit, exec_silent = true },
                    },
                },
                vim.keymap.set("n", "<C-g><C-b><C-r>", fzf_lua.git_branches, {
                    desc = "FzfLua [G]it [B][R]ances",
                }),
                branches = {
                    prompt = "Git Branches❯ ",
                    cmd = "git branch --all --color",
                    preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
                    remotes = "local",
                    actions = {
                        ["enter"] = FzfLua.actions.git_switch,
                        ["ctrl-a"] = { fn = FzfLua.actions.git_branch_add, field_index = "{q}", reload = true },
                        ["ctrl-d"] = { fn = FzfLua.actions.git_branch_del, reload = true },
                    },
                    -- If you wish to add branch and switch immediately
                    -- cmd_add  = { "git", "checkout", "-b" },
                    cmd_add = { "git", "branch" },
                    -- If you wish to delete unmerged branches add "--force"
                    -- cmd_del  = { "git", "branch", "--delete", "--force" },
                    cmd_del = { "git", "branch", "--delete" },
                },
                vim.keymap.set("n", "<C-g><C-w>", fzf_lua.git_worktrees, {
                    desc = "FzfLua [G]it [W]orktrees",
                }),
                worktrees = {
                    prompt = "Git Worktrees❯ ",
                    actions = {
                        ["ctrl-a"] = { fn = FzfLua.actions.git_worktree_add, field_index = "{q}", reload = true },
                        ["ctrl-d"] = { fn = FzfLua.actions.git_worktree_del, reload = true },
                    },
                },
                vim.keymap.set("n", "<C-g><C-t>", fzf_lua.git_tags, {
                    desc = "FzfLua [G]it [T]ags",
                }),
                tags = {
                    prompt = "Git Tags> ",
                    cmd = [[git for-each-ref --color --sort="-taggerdate" --format ]]
                        .. [["%(color:yellow)%(refname:short)%(color:reset) ]]
                        .. [[%(color:green)(%(taggerdate:relative))%(color:reset)]]
                        .. [[ %(subject) %(color:blue)%(taggername)%(color:reset)" refs/tags]],
                    preview = [[git log --graph --color --pretty=format:"%C(yellow)%h%Creset ]]
                        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {1}]],
                    actions = { ["enter"] = FzfLua.actions.git_checkout },
                },
                vim.keymap.set("n", "<C-g><C-s><C-t>", fzf_lua.git_stash, {
                    desc = "FzfLua [G]it [S]tashes",
                }),
                stash = {
                    prompt = "Git Stash> ",
                    cmd = "git --no-pager stash list",
                    preview = "git --no-pager stash show --patch --color {1}",
                    actions = {
                        ["enter"] = FzfLua.actions.git_stash_apply,
                        ["ctrl-d"] = { fn = FzfLua.actions.git_stash_drop, reload = true },
                    },
                },
                icons = {
                    ["M"] = { icon = "M", color = "yellow" },
                    ["D"] = { icon = "D", color = "red" },
                    ["A"] = { icon = "A", color = "green" },
                    ["R"] = { icon = "R", color = "yellow" },
                    ["C"] = { icon = "C", color = "yellow" },
                    ["T"] = { icon = "T", color = "magenta" },
                    ["?"] = { icon = "?", color = "magenta" },
                },
            },
            vim.keymap.set("n", "<C-s>", fzf_lua.live_grep, {
                desc = "FzfLua [S]earch",
            }),
            grep = {
                prompt = "Rg❯ ",
                input_prompt = "Grep For❯ ",
                multiprocess = true,
                rg_opts = [[ \
                            --column \
                            --line-number \
                            --no-heading \
                            --color=always \
                            --max-columns=4096 \
                            --iglob "!**/*.bak" \
                            --iglob "!**/*.db" \
                            --iglob "!**/*.exe" \
                            --iglob "!**/*.lock" \
                            --iglob "!**/*.log" \
                            --iglob "!**/*.min.js" \
                            --iglob "!**/*.o" \
                            --iglob "!**/*.rar" \
                            --iglob "!**/*.sqlite" \
                            --iglob "!**/*.sqlite3" \
                            --iglob "!**/*.stfolder" \
                            --iglob "!**/*.stversions" \
                            --iglob "!**/*.swp" \
                            --iglob "!**/*.tar.gz" \
                            --iglob "!**/*.tmp" \
                            --iglob "!**/*.zip" \
                            --iglob "!**/.cache" \
                            --iglob "!**/.git" \
                            --iglob "!**/.parcel-cache" \
                            --iglob "!**/.venv" \
                            --iglob "!**/.yarn" \
                            --iglob "!**/__pycache__" \
                            --iglob "!**/bin" \
                            --iglob "!**/build" \
                            --iglob "!**/dist" \
                            --iglob "!**/logs" \
                            --iglob "!**/node_modules" \
                            --iglob "!**/obj" \
                            --iglob "!**/out" \
                            --iglob "!**/target" \
                            --iglob "!**/tmp" \
                            --iglob "!**/vendor" \
                            --regexp \
                          ]],

                hidden = true,
                follow = false,
                no_ignore = false,
                RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
                rg_glob = true,
                glob_flag = "--iglob",
                glob_separator = "%s%-%-",
            },
            args = {
                prompt = "Args❯ ",
                files_only = true,
                actions = {
                    ["ctrl-d"] = { fn = FzfLua.actions.arg_del, reload = true },
                },
            },
            oldfiles = {
                prompt = "History❯ ",
            },
            vim.keymap.set("n", "<C-b>", fzf_lua.buffers, {
                desc = "FzfLua [B]uffers",
            }),
            buffers = {
                prompt = "Buffers❯ ",
                actions = {
                    ["ctrl-d"] = { fn = FzfLua.actions.buf_del, reload = true },
                },
            },
            tabs = {
                prompt = "Tabs❯ ",
                tab_title = "Tab",
                tab_marker = "<<",
                actions = {
                    ["enter"] = FzfLua.actions.buf_switch,
                    ["ctrl-d"] = { fn = FzfLua.actions.buf_del, reload = true },
                },
            },
            lines = {
                prompt = "Lines❯ ",
            },
            vim.keymap.set("n", "<C-f>", fzf_lua.blines, {
                desc = "FzfLua [F]uzzy Find",
            }),
            blines = {
                prompt = "Fuzzy Find❯ ",
                winopts = {
                    syntax = true,
                    treesitter = {
                        enabled = true,
                    },
                },
                previewer = false,
            },
            tags = {
                prompt = "Tags❯ ",
            },
            btags = {
                prompt = "BTags❯ ",
            },
            colorschemes = {
                prompt = "Colorschemes❯ ",
                winopts = {
                    height = 0.55,
                    width = 0.30,
                },
                actions = {
                    ["enter"] = FzfLua.actions.colorscheme,
                },
            },
            awesome_colorschemes = {
                prompt = "Colorschemes❯ ",
                live_preview = true,
                winopts = {
                    row = 0,
                    col = 0.99,
                    width = 0.50,
                },
                actions = {
                    ["enter"] = FzfLua.actions.colorscheme,
                    ["ctrl-g"] = { fn = FzfLua.actions.toggle_bg, exec_silent = true },
                    ["ctrl-r"] = { fn = FzfLua.actions.cs_update, reload = true },
                    ["ctrl-d"] = { fn = FzfLua.actions.cs_delete, reload = true },
                },
            },
            keymaps = {
                prompt = "Keymaps> ",
                winopts = {
                    preview = {
                        layout = "vertical",
                    },
                },
                ignore_patterns = { "^<SNR>", "^<Plug>" },
                show_desc = true,
                show_details = true,
                actions = {
                    ["enter"] = FzfLua.actions.keymap_apply,
                    ["ctrl-s"] = FzfLua.actions.keymap_split,
                    ["ctrl-v"] = FzfLua.actions.keymap_vsplit,
                },
            },
            nvim_options = {
                prompt = "Nvim Options> ",
                separator = "│",
                color_values = true,
                actions = {
                    ["enter"] = { fn = FzfLua.actions.nvim_opt_edit_local, reload = true },
                    ["alt-enter"] = { fn = FzfLua.actions.nvim_opt_edit_global, reload = true },
                },
            },
            quickfix = {
                prompt = "Quickfix> ",
                file_icons = true,
                valid_only = false,
            },
            quickfix_stack = {
                prompt = "Quickfix Stack> ",
                marker = ">",
            },
            lsp = {
                prompt_postfix = "❯ ", -- will be appended to the LSP label
                cwd_only = false,
                async_or_timeout = 5000,
                symbols = {
                    locate = false,
                    async_or_timeout = true,
                    -- style for document/workspace symbols
                    -- false: disable,    1: icon+kind
                    --     2: icon only,  3: kind only
                    symbol_style = 1,
                    symbol_icons = {
                        File = "󰈙",
                        Module = "",
                        Namespace = "󰦮",
                        Package = "",
                        Class = "󰆧",
                        Method = "󰊕",
                        Property = "",
                        Field = "",
                        Constructor = "",
                        Enum = "",
                        Interface = "",
                        Function = "󰊕",
                        Variable = "󰀫",
                        Constant = "󰏿",
                        String = "",
                        Number = "󰎠",
                        Boolean = "󰨙",
                        Array = "󱡠",
                        Object = "",
                        Key = "󰌋",
                        Null = "󰟢",
                        EnumMember = "",
                        Struct = "󰆼",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "󰗴",
                    },
                },
                code_actions = {
                    prompt = "Code Actions> ",
                    async_or_timeout = 5000,
                    previewer = "codeaction",
                },
                finder = {
                    prompt = "LSP Finder> ",
                    async = true, -- async by default
                    silent = true, -- suppress "not found"
                    separator = "| ", -- separator after provider prefix, `false` to disable
                    providers = {
                        -- { "references", prefix = FzfLua.utils.ansi_codes.blue("ref ") },
                        -- { "definitions", prefix = FzfLua.utils.ansi_codes.green("def ") },
                        -- { "declarations", prefix = FzfLua.utils.ansi_codes.magenta("decl") },
                        -- { "typedefs", prefix = FzfLua.utils.ansi_codes.red("tdef") },
                        -- { "implementations", prefix = FzfLua.utils.ansi_codes.green("impl") },
                        -- { "incoming_calls", prefix = FzfLua.utils.ansi_codes.cyan("in  ") },
                        -- { "outgoing_calls", prefix = FzfLua.utils.ansi_codes.yellow("out ") },
                        -- { "type_sub", prefix = FzfLua.utils.utils.ansi_codes.cyan("sub ") },
                        -- { "type_super", prefix = FzfLua.utils.utils.ansi_codes.yellow("supr") },
                    },
                },
            },
            diagnostics = {
                prompt = "Diagnostics❯ ",
                color_headings = true,
                diag_icons = true,
                diag_source = true,
                diag_code = true,
                icon_padding = "",
                multiline = 2,
            },
            marks = {
                marks = "",
            },
            complete_path = {
                cmd = nil,
                complete = {
                    ["enter"] = FzfLua.actions.complete,
                },
            },
            complete_file = {
                cmd = nil,
                actions = {
                    ["enter"] = FzfLua.actions.complete,
                },
                winopts = {
                    preview = {
                        hidden = true,
                    },
                },
            },
            zoxide = {
                cmd = "zoxide query --list --score",
                scope = "global",
                git_root = false,
                formatter = "path.dirname_first",
                actions = {
                    enter = FzfLua.actions.cd,
                },
            },
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("fzflua-lsp-attach", {
                    clear = true,
                }),
                callback = function(event)
                    vim.keymap.set("n", "grr", fzf_lua.lsp_references, {
                        buffer = event.buf,
                        desc = "[G]oto [R]eferences",
                    })
                    vim.keymap.set("n", "gri", fzf_lua.lsp_implementations, {
                        buffer = event.buf,
                        desc = "[G]oto [I]mplementations",
                    })
                    vim.keymap.set("n", "grd", fzf_lua.lsp_definitions, {
                        buffer = event.buf,
                        desc = "[G]oto [D]efinitions",
                    })
                    vim.keymap.set("n", "grD", fzf_lua.lsp_declarations, {
                        buffer = event.buf,
                        desc = "[G]oto [D]eclaration",
                    })
                    vim.keymap.set("n", "grt", fzf_lua.lsp_typedefs, {
                        buffer = event.buf,
                        desc = "[G]oto [T]ype Definition",
                    })
                    vim.keymap.set("n", "gra", fzf_lua.lsp_code_actions, {
                        buffer = event.buf,
                        desc = "[G]oto Code [A]ction",
                    })
                    vim.keymap.set("n", "grs", fzf_lua.lsp_document_symbols, {
                        buffer = event.buf,
                        desc = "Open Document [S]ymbols",
                    })
                    vim.keymap.set("n", "grw", fzf_lua.lsp_workspace_symbols, {
                        buffer = event.buf,
                        desc = "Open [W]orkspace Symbols",
                    })
                    vim.keymap.set("n", "<C-d><C-d>", fzf_lua.lsp_document_diagnostics, {
                        buffer = event.buf,
                        desc = "Open [D]iagnostics for [D]ocument",
                    })
                    vim.keymap.set("n", "<C-d><C-w>", fzf_lua.lsp_workspace_diagnostics, {
                        buffer = event.buf,
                        desc = "Open [D]iagnostics for [W]orkspace",
                    })
                end,
            }),
        })
    end,
}
