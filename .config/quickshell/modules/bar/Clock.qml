import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
// import qs.services
import "../../services"

// import "../../components"
// import "../launcher"

Text {
    text: ClockService.time
    font.family: "Inter"
    font.pixelSize: 16
    font.weight: Font.Black
    color: "#ffffff"
    lineHeight: 0.9
}
