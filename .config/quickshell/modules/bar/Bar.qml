import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
// import qs.services
// import "../../services"
import "../../components"
import "../launcher"

PanelWindow {
    id: root
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 34
    color: "#01000000"
    // color: "transparent"
    screen: Quickshell.screens[0]

    readonly property int gapIn: 8
    readonly property int gapOut: 4

    required property var launcherWindow
    required property var controlcenterWindow

    // Left
    RowLayout {
        anchors {
            left: parent.left
            leftMargin: root.gapOut
            verticalCenter: parent.verticalCenter
        }
        spacing: root.gapIn

        // AppMenuButton {}
        BarButton {
            icon: "󰣇"
            onClicked: root.launcherWindow.visible = !root.launcherWindow.visible
        }
    }

    // Center
    RowLayout {
        anchors {
            centerIn: parent
            verticalCenter: parent.verticalCenter
            leftMargin: root.gapOut
            rightMargin: root.gapOut
        }
        spacing: root.gapIn
    }

    // Right
    RowLayout {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: root.gapOut
        }
        spacing: root.gapIn

        Network {}
        SystemUsage {}
        Clock {}
        BarButton {
            icon: "󰒓"
            onClicked: root.controlcenterWindow.visible = !root.controlcenterWindow.visible
        }
    }
}
