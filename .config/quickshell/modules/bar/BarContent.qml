import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../controls"

Item {
    id: root
    // anchors.fill: parent
    implicitHeight: 34

    readonly property int gapIn: 8
    readonly property int gapOut: 4

    // Left
    RowLayout {
        anchors {
            left: parent.left
            leftMargin: root.gapOut
            verticalCenter: parent.verticalCenter
        }
        spacing: root.gapIn

        // AppMenuButton {}
        IconButton {
            icon: "󰣇"
            onClicked: ShellState.launcher = !ShellState.launcher
        }
        SystemTray {}
    }

    // Center
    Mpris {
        anchors {
            centerIn: parent
            verticalCenter: parent.verticalCenter
            leftMargin: root.gapOut
            rightMargin: root.gapOut
        }
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
        IconButton {
            icon: ""
            onClicked: ShellState.controlcenter = true
        }
    }
}
