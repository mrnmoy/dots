import Quickshell
import Quickshell.Hyprland
import "./modules/bar"
import "./modules/notification"
import "./modules/controlcenter"
import "./modules/launcher"
import "./modules/help"
import "./modules/osd"
import "./modules"
import "./services"

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
    }
    LauncherWindow {
        id: launcherWindow
        // visible: ShellState.launcher
        visible: false

        GlobalShortcut {
            name: "launcher"
            description: "Application Launcher"

            onPressed: {
                // ScreenState.launcher = !ScreenState.launcher;
                launcherWindow.visible = !launcherWindow.visible;
            }
        }
    }
    NotificationWindow {}
    Shortcuts {}

    OsdWindow {
        id: osdWindow
        visible: true

        GlobalShortcut {
            name: "osd"
            description: "Toggle OSD"

            onPressed: {
                osdWindow.visible = !osdWindow.visible;
            }
        }
    }
    HelpWindow {
        id: helpWindow
        visible: false

        // GlobalShortcut {
        //     name: "help"
        //     description: "Keybinds help"
        //
        //     onPressed: {
        //         // helpWindow.visible = !helpWindow.visible;
        //     }
        // }
    }

    // Item {}
}
