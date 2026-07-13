import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../services"
import "../../components"

RowLayout {
    id: root

    Text {
        text: " " + formatBytes(NetworkService.downBytesSec)
        color: "#ffffff"
        font.pixelSize: 16
    }
    Text {
        text: " " + formatBytes(NetworkService.upBytesSec)
        color: "#ffffff"
        font.pixelSize: 16
    }

    function formatBytes(bytes: int): string {
        if (bytes < 1024) {
            return (bytes / 1.0).toFixed(1) + "B/s";
        } else if (bytes < 1024000) {
            return (bytes / 1024.0).toFixed(1) + "K/s";
        } else if (bytes < 1024000000) {
            return (bytes / 1024000.0).toFixed(1) + "M/s";
        } else {
            return (bytes / 1024000000.0).toFixed(1) + "G/s";
        }
    }
}

// Scope {
//     id: root
//
//     Variants {
//         model: Quickshell.screens
//
//         Component.onCompleted: {
//             NetworkService.interfacename = "enp0s20u1";
//         }
//     }
// }
