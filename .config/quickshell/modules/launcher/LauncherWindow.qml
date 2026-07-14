import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../components"
import "../../services"
import "../notification"

PanelWindow {
    id: root

    anchors {
        // left: true
        bottom: true
        // right: true
    }
    exclusionMode: ExclusionMode.Ignore
    // margins {
    //     left: 8
    //     right: 8
    //     bottom: 0
    // }

    implicitWidth: Math.min(640, screen.width / 1.5) + 32
    implicitHeight: Math.min(420, screen.height - 40)
    color: "transparent"

    screen: Quickshell.screens[0]
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    FocusScope {
        id: panelContent
        anchors.fill: parent

        transformOrigin: Item.TopRight
        scale: visible ? 1.0 : 0.5
        opacity: visible ? 1.0 : 0.0

        focus: true
        Keys.onEscapePressed: root.visible = false

        HoverHandler {
            id: hoverHandler
            onHoveredChanged: {
                if (hovered)
                    closeTimer.stop();
                else if (root.visible)
                    closeTimer.restart();
            }
        }

        Timer {
            id: closeTimer
            interval: 150
            onTriggered: if (!hoverHandler.hovered)
                root.visible = false
        }

        // Behavior on scale {
        //     NumberAnimation {
        //         duration: 550
        //         easing.bezierCurve: [0.85, 0, 0.15, 1]
        //     }
        // }
        // Behavior on opacity {
        //     NumberAnimation {
        //         duration: 550
        //         easing.bezierCurve: [0.85, 0, 0.15, 1]
        //     }
        // }

        InvertedCorner {
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            rotation: 90
        }
        InvertedCorner {
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
            rotation: 180
        }

        Rectangle {
            id: panel
            // anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: parent.width - 32
            implicitHeight: parent.height
            color: "#0fffffff"
            topRightRadius: 16
            topLeftRadius: 16
            layer.enabled: true
            clip: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 32
                    // Layout.alignment: Qt.AlignTop
                    color: "#0fffffff"
                    radius: 16

                    RowLayout {
                        anchors.fill: parent
                        Layout.leftMargin: 16
                        Layout.rightMargin: 16
                        spacing: 16

                        Text {
                            text: ""
                            font.pixelSize: 16
                            font.weight: Font.Black
                            color: "#ffffff"
                            // lineHeight: 0.9
                        }
                        TextField {
                            font.family: "Inter"
                            font.pixelSize: 16
                            font.weight: Font.Medium
                            color: "#f1f1f1"
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

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        // Sliders
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
