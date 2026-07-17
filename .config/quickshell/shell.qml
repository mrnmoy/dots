import QtQuick
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

    property bool osd
    property bool launcher
    property bool controlcenter
    property bool help

    // Binding {
    //     target: ShellState
    //     property: "shellRoot"
    //     value: root
    // }

    Bar {
        controlcenterWindow: controlcenterWindow
        launcherWindow: launcherWindow
    }

    LauncherWindow {
        id: launcherWindow
        visible: root.launcher
    }
    ControlCenterWindow {
        id: controlcenterWindow
        visible: root.controlcenter
    }
    NotificationWindow {}

    OsdWindow {
        id: osdWindow
        visible: root.osd
    }
    HelpWindow {
        id: helpWindow
        visible: root.help
    }

    // Shortcuts {}
    GlobalShortcut {
        name: "launcher"
        description: "Toggle application launcher"

        onPressed: {
            root.launcher = !root.launcher;
            console.log("launcher triggered");
        }
    }
    GlobalShortcut {
        name: "controlcenter"
        description: "Toggle control center"

        onPressed: {
            root.controlcenter = !root.controlcenter;
        }
    }
    GlobalShortcut {
        name: "osd"
        description: "Toggle osd"

        onPressed: {
            root.osd = !root.osd;
        }
    }
    GlobalShortcut {
        name: "help"
        description: "Toggle keybinds help"

        onPressed: {
            root.help = !root.help;
        }
    }
}
