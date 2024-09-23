
require("mason").setup({
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
    PATH = "prepend",
    registries = {
        "github:mason-org/mason-registry",
    },
    providers = {
        "mason.providers.registry-api",
        "mason.providers.client",
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    ui = {
        check_outdated_packages_on_open = true,
        border = "none",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
})

