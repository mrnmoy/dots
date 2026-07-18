import Quickshell
import Quickshell.Hyprland
import "../services"

Scope {
    id: root

    GlobalShortcut {
        name: "launcher"
        description: "Toggle application launcher"

        onPressed: {
            ShellState.launcher = !ShellState.launcher;
        }
    }

    GlobalShortcut {
        name: "controlcenter"
        description: "Toggle control center"

        onPressed: {
            ShellState.controlcenter = !ShellState.controlcenter;
        }
    }

    GlobalShortcut {
        name: "osd"
        description: "Toggle osd"

        onPressed: {
            ShellState.osd = !ShellState.osd;
        }
    }

    GlobalShortcut {
        name: "help"
        description: "Toggle keybinds help"

        onPressed: {
            ShellState.help = !ShellState.help;
        }
    }

    GlobalShortcut {
        name: "showcase"
        description: "Toggle launcher, osd, controlcenter"

        onPressed: {
            console.log("showcase triggered");
            ShellState.launcher = ShellState.osd = ShellState.controlcenter = !(ShellState.launcher || ShellState.osd || ShellState.controlcenter);
        }
    }
}
