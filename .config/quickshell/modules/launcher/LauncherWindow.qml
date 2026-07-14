import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    anchors {
        bottom: true
    }

    color: "transparent"
    implicitWidth: Math.min(540, screen.width - 40)
    implicitHeight: Math.min(640, screen.height - 40)

    screen: Quickshell.screens[0]
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
    exclusionMode: ExclusionMode.Ignore

    FocusScope {
        id: panelContent
        anchors.fill: parent

        transformOrigin: Item.Bottom
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
            interval: 500
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

        MultiEffect {
            source: background
            anchors.fill: background
            maskEnabled: true
            maskSource: mask

            layer.smooth: true

            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
        }

        Rectangle {
            id: background
            anchors.fill: parent
            visible: false
            smooth: true
            color: "#01000000"
        }

        Shape {
            id: mask
            anchors.fill: background
            antialiasing: true

            visible: false
            layer.enabled: true

            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                strokeColor: "transparent"

                startX: 0
                startY: mask.height

                PathArc {
                    direction: PathArc.Counterclockwise
                    radiusX: 20
                    radiusY: 20
                    x: 20
                    y: mask.height - 20
                }
                PathLine {
                    x: 20
                    y: 20
                }
                PathArc {
                    radiusX: 20
                    radiusY: 20
                    x: 40
                    y: 0
                }
                PathLine {
                    x: mask.width - 40
                    y: 0
                }
                PathArc {
                    direction: PathArc.Clockwise
                    radiusX: 20
                    radiusY: 20
                    x: mask.width - 20
                    y: 20
                }
                PathLine {
                    x: mask.width - 20
                    y: mask.height - 20
                }
                PathArc {
                    direction: PathArc.Counterclockwise
                    radiusX: 20
                    radiusY: 20
                    x: mask.width
                    y: mask.height
                }
                PathLine {
                    x: 0
                    y: mask.height
                }
            }
        }

        ColumnLayout {
            anchors.fill: background
            anchors.topMargin: 16
            anchors.leftMargin: 32
            anchors.rightMargin: 32
            spacing: 16

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 40
                color: "#0fffffff"
                radius: 20

                RowLayout {
                    anchors.fill: parent
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    spacing: 16

                    Text {
                        text: "󰣇"
                        font.pixelSize: 20
                        font.weight: Font.Black
                        color: "#ffffff"
                        Layout.leftMargin: 16
                    }
                    // TextField {
                    //     font.family: "Inter"
                    //     font.pixelSize: 16
                    //     font.weight: Font.Medium
                    //     color: "#f1f1f1"
                    // }
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
