import Quickshell
import Quickshell.Hyprland
import "./modules/bar"
import "./modules/notification"
import "./modules/controlcenter"

// import "./modules"

ShellRoot {
    id: root

    Bar {}
    // Notification {}
    ControlCenterWindow {
        id: controlcenter
        visible: false
    }

    GlobalShortcut {
        name: "controls_center"
        description: "Controls Center"

        onPressed: {
            controlcenter.visible = !controlcenter.visible;
            // root.centerOpen = !root.centerOpen;
            // if (root.centerOpen)
            //     root.onScreenNotifications.clear();
        }
    }
}
