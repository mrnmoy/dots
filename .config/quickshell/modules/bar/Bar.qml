import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
// import qs.services
import "../../services"
import "../../components"
import "../launcher"

PanelWindow {
    id: root

    readonly property int gapIn: 8
    readonly property int gapOut: 4

    required property var launcherWindow
    required property var controlcenterWindow

    screen: Quickshell.screens[0]
    // color: "transparent"
    color: "#01000000"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 34

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
        Text {
            text: ClockService.time
            font.family: "Inter"
            font.pixelSize: 16
            font.weight: Font.Black
            color: "#ffffff"
            lineHeight: 0.9
        }
        BarButton {
            icon: "󰒓"
            onClicked: root.controlcenterWindow.visible = !root.controlcenterWindow.visible
        }
    }

    // Text {
    //     text: Network.connected ? "Connected" : "Disconnected"
    //     color: "#ffffff"
    // }

    // GlobalShortcut {
    //     name: "app_launcher"
    //     description: "Application Launcher"
    //
    //     onPressed: {}
    // }

    GlobalShortcut {
        name: "keybinds_help"
        description: "Keybinds help"

        onPressed: {}
    }
}
