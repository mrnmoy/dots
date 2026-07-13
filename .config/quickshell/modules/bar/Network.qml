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
        font.family: "Inter"
        font.pixelSize: 16
        font.weight: Font.Black
        color: "#ffffff"
        lineHeight: 0.9
    }
    Text {
        text: " " + formatBytes(NetworkService.upBytesSec)
        font.family: "Inter"
        font.pixelSize: 16
        font.weight: Font.Black
        color: "#ffffff"
        lineHeight: 0.9
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
