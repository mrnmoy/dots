import Quickshell
import Quickshell.Hyprland
import "../services"

Scope {
    id: root

    GlobalShortcut {
        name: "showcase"
        description: "Toggle launcher, osd, controlcenter"

        onPressed: {
            console.log("showcase triggered");
            ShellState.launcher = ShellState.osd = ShellState.controlcenter = !(ShellState.launcher || ShellState.osd || ShellState.controlcenter);
        }
    }

    GlobalShortcut {
        name: "launcher"
        description: "Toggle Application Launcher"

        onPressed: {
            ShellState.launcher = !ShellState.launcher;
            console.log("launcher triggered ");
            // launcherWindow.visible = !launcherWindow.visible;
        }
    }

    GlobalShortcut {
        name: "controlcenter"
        description: "Controls Center"

        onPressed: {
            // controlcenterWindow.visible = !controlcenterWindow.visible;

            // root.centerOpen = !root.centerOpen;
            // if (root.centerOpen)
            //     root.onScreenNotifications.clear();
        }
    }

    GlobalShortcut {
        name: "help"
        description: "Keybinds help"

        onPressed: {
            // helpWindow.visible = !helpWindow.visible;
        }
    }
}
