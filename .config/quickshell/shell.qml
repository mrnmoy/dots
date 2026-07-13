import Quickshell
import Quickshell.Hyprland
import "./modules/bar"
import "./modules/notification"
import "./modules/controlcenter"
import "./modules/launcher"
import "./modules/help"

// import "./modules"

ShellRoot {
    id: root

    Bar {
        controlcenterWindow: controlcenterWindow
        launcherWindow: launcherWindow
    }

    // Notification {}
    ControlCenterWindow {
        id: controlcenterWindow
        visible: false
    }
    LauncherWindow {
        id: launcherWindow
        visible: false
    }
    HelpWindow {
        id: helpWindow
        visible: false
    }

    GlobalShortcut {
        name: "launcher"
        description: "Application Launcher"

        onPressed: {
            launcherWindow.visible = !launcherWindow.visible;
        }
    }

    GlobalShortcut {
        name: "controlcenter"
        description: "Controls Center"

        onPressed: {
            controlcenterWindow.visible = !controlcenterWindow.visible;
            // root.centerOpen = !root.centerOpen;
            // if (root.centerOpen)
            //     root.onScreenNotifications.clear();
        }
    }

    GlobalShortcut {
        name: "help"
        description: "Keybinds help"

        onPressed: {
            helpWindow.visible = !helpWindow.visible;
        }
    }
}
