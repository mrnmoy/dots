import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../services"
import "../../components"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        Component.onCompleted: {
            NetworkService.interfacename = "enp0s20u1";
        }
    }
}
