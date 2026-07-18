import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../components"
import "../../services"

PanelWindow {
    id: root
    visible: active
    readonly property bool active: ShellState.help

    exclusionMode: ExclusionMode.Normal

    implicitWidth: Math.min(640, screen.width - 40)
    implicitHeight: Math.min(520, screen.height - 40)
    color: "transparent"

    screen: Quickshell.screens[0]
    WlrLayershell.keyboardFocus: active ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    FocusScope {
        id: panelContent
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: ShellState.help = false

        HoverHandler {
            id: hoverHandler
            onHoveredChanged: {
                if (hovered)
                    closeTimer.stop();
                else if (root.active)
                    closeTimer.restart();
            }
        }

        Timer {
            id: closeTimer
            interval: 500
            onTriggered: if (!hoverHandler.hovered)
                ShellState.help = false
        }

        Rectangle {
            id: panel
            anchors.fill: parent
            anchors.margins: 16
            radius: 16
            color: "#0fffffff"
            clip: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16

                RowLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                    spacing: 16

                    ColumnLayout {
                        spacing: 0

                        Text {
                            text: "Keybinds"
                            font.family: "Inter"
                            font.pixelSize: 42
                            font.weight: Font.Black
                            color: "#ffffff"
                            lineHeight: 0.9
                        }
                        Text {
                            text: "Specified in hyprland config"
                            font.family: "Inter"
                            font.pixelSize: 12
                            font.weight: Font.Medium
                            color: "#f1f1f1"
                            lineHeight: 1.5
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        spacing: 8

                        BarButton {
                            icon: "󰒓"
                        }
                    }
                }

                Flickable {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    // contentHeight: content.height

                    maximumFlickVelocity: 3000
                    flickDeceleration: 1500
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    boundsMovement: Flickable.FollowBoundsBehavior

                    rebound: Transition {
                        NumberAnimation {
                            properties: "x,y"
                            duration: 150
                            easing.bezierCurve: [0.85, 0, 0.15, 1]
                        }
                    }

                    // ListView {
                    //     clip: true
                    //     spacing: 8
                    //     model: NotificationService.trackedNotifications ?? []
                    //     delegate: NotificationCard {}
                    // }
                }
            }
        }
    }
}
