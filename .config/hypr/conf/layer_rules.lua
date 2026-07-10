hl.layer_rule({
    name = "quickshell",
    blur = true,
    blur_popups = true,
    ignore_alpha = 0,
    match = { namespace = "quickshell" }
})
-- hl.layer_rule({
--     name = "quickshell-bar",
--     blur = true,
--     blur_popups = true,
--     ignore_alpha = 0,
--     match = { namespace = "quickshell:bar" }
-- })
hl.layer_rule({
    name = "waybar-blur",
    blur = true,
    blur_popups = true,
    ignore_alpha = 0,
    match = { namespace = "waybar" }
})
hl.layer_rule({
    name = "wlogout-blur",
    blur = true,
    match = { namespace = "logout_dialog" }
})
hl.layer_rule({
    name = "swaync-control-center-blur",
    blur = true,
    -- blur_popups = true,
    ignore_alpha = 0,
    dim_around = true,
    match = { namespace = "swaync-control-center" }
})
hl.layer_rule({
    name = "swaync-notification-window-blur",
    blur = true,
    ignore_alpha = 0,
    match = { namespace = "swaync-notification-window" }
})
hl.layer_rule({
    name = "rofi-blur",
    blur = true,
    ignore_alpha = 0,
    dim_around = true,
    match = { namespace = "rofi" }
})
hl.layer_rule({
    name = "vicinea-blur",
    blur = true,
    ignore_alpha = 0,
    match = { namespace = "vicinea" }
})
