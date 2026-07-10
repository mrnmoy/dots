hl.window_rule({
    name = "pip",
    match = { title = "Picture-in-Picture" },
    float = true,
    move = "20 monitor_w-120"
})
hl.window_rule({
    name = "file-progress-float",
    match = { title = "File Operation Progress" },
    float = true,
    size = "510 102"
})
hl.window_rule({
    name = "feh",
    match = { class = "feh" },
    float = true,
})
hl.window_rule({
    name = "spotube-float",
    match = { class = "spotube" },
    float = true,
})
hl.window_rule({
    name = "scrcpy-float",
    match = { class = "scrcpy" },
    float = true,
    keep_aspect_ratio = true
})
hl.window_rule({
    name = "rmpc-float",
    match = { title = "rmpc" },
    float = true,
})
hl.window_rule({
    name = "kicad-tile",
    match = { title = "KiCad" },
    float = true,
})
hl.window_rule({
    name = "ueberzugpp-float",
    match = { class = "^(ueberzugpp)(.*)$" },
    float = true,
    no_initial_focus = true
})
hl.window_rule({
    name = "qtcreator-preview-float",
    match = { title = "^(Hello World)(.*)$" },
    float = true,
})
hl.window_rule({
    name = "qtcreator-waiting-float",
    match = { title = "^(Waiting for Applications to Stop — Qt Creator)(.*)$" },
    float = true,
})
