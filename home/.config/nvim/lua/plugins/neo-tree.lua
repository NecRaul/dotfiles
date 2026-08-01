return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
        local neo_tree = require("neo-tree")
        neo_tree.setup({
            close_if_last_window = true,
            popup_border_style = "NC",
            clipboard = {
                sync = "none",
            },
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
            open_files_using_relative_paths = false,
            sort_case_insensitive = false,
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeFileIcon",
                    with_expanders = nil,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    provider = function(icon, node)
                        if node.type == "file" or node.type == "terminal" then
                            local success, web_devicons = pcall(require, "nvim-web-devicons")
                            local name = node.type == "terminal" and "terminal" or node.name
                            if success then
                                local devicon, hl = web_devicons.get_icon(name)
                                icon.text = devicon or icon.text
                                icon.highlight = hl or icon.highlight
                            end
                        end
                    end,
                    default = "*",
                    highlight = "NeoTreeFileIcon",
                    use_filtered_colors = true,
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_filtered_colors = true,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        added = "✚",
                        modified = "",
                        deleted = "✖",
                        renamed = "󰁕",
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
                file_size = {
                    enabled = true,
                    width = 12,
                    required_width = 64,
                },
                type = {
                    enabled = true,
                    width = 10,
                    required_width = 122,
                },
                last_modified = {
                    enabled = true,
                    width = 20,
                    required_width = 88,
                },
                created = {
                    enabled = true,
                    width = 20,
                    required_width = 110,
                },
                symlink_target = {
                    enabled = false,
                },
            },
            commands = {},
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<Tab>"] = "select",
                    ["<space>"] = "clear_selection",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel",
                    ["P"] = "toggle_preview",
                    ["s"] = "open_split",
                    ["v"] = "open_vsplit",
                    ["C"] = "close_all_subnodes",
                    ["E"] = "expand_all_subnodes",
                    ["a"] = "add",
                    ["A"] = "add_directory",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["b"] = "rename_basename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["<C-r>"] = "clear_clipboard",
                    ["c"] = "copy",
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    ["i"] = "show_file_details",
                    ["w"] = "none",
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_ignored = true,
                    hide_by_name = {
                        "node_modules",
                        ".git",
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = false,
                hijack_netrw_behavior = "open_default",
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                        ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                        },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["og"] = { "order_by_git_status", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                    fuzzy_finder_mappings = {
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                        ["<esc>"] = "close",
                        ["<S-CR>"] = "close_keep_filter",
                        ["<C-CR>"] = "close_clear_filter",
                        ["<C-w>"] = { "<C-S-w>", raw = true },
                        {
                            n = {
                                ["j"] = "move_cursor_down",
                                ["k"] = "move_cursor_up",
                                ["<esc>"] = "close",
                                ["<S-CR>"] = "close_keep_filter",
                                ["<C-CR>"] = "close_clear_filter",
                            },
                        },
                    },
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                show_unloaded = true,
                window = {
                    mappings = {
                        ["d"] = "buffer_delete",
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                        },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["gU"] = "git_undo_last_commit",
                        ["ga"] = "git_add_file",
                        ["gt"] = "git_toggle_file_stage",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gl"] = "git_pull",
                        ["gg"] = "git_commit_and_push",
                        ["o"] = {
                            "show_help",
                            nowait = false,
                            config = { title = "Order by", prefix_key = "o" },
                        },
                        ["oc"] = { "order_by_created", nowait = false },
                        ["od"] = { "order_by_diagnostics", nowait = false },
                        ["om"] = { "order_by_modified", nowait = false },
                        ["on"] = { "order_by_name", nowait = false },
                        ["os"] = { "order_by_size", nowait = false },
                        ["ot"] = { "order_by_type", nowait = false },
                    },
                },
            },
        })
    end,
    vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { link = "DiffDelete" }),
}
