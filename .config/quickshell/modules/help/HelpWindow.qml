import QtQuick
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

        // Rectangle {
        //     id: panel
        //     anchors.fill: parent
        //     // implicitWidth: 100
        //     // implicitHeight: 50
        //     anchors.margins: 16
        //     radius: 16
        //     color: "#0fffffff"
        //     clip: true
        //
        //     ColumnLayout {
        //         anchors.fill: parent
        //         anchors.margins: 16
        //         spacing: 16
        //
        //         RowLayout {
        //             Layout.fillWidth: true
        //             Layout.alignment: Qt.AlignTop
        //             spacing: 16
        //
        //             ColumnLayout {
        //                 spacing: 0
        //
        //                 Text {
        //                     text: "Keybinds"
        //                     font.family: "Inter"
        //                     font.pixelSize: 42
        //                     font.weight: Font.Black
        //                     color: "#ffffff"
        //                     lineHeight: 0.9
        //                 }
        //                 Text {
        //                     text: "Specified in hyprland config"
        //                     font.family: "Inter"
        //                     font.pixelSize: 12
        //                     font.weight: Font.Medium
        //                     color: "#f1f1f1"
        //                     lineHeight: 1.5
        //                 }
        //             }
        //
        //             Item {
        //                 Layout.fillWidth: true
        //             }
        //
        //             RowLayout {
        //                 spacing: 8
        //
        //                 BarButton {
        //                     icon: "󰒓"
        //                 }
        //             }
        //         }
        //
        //         Flickable {
        //             Layout.fillWidth: true
        //             Layout.fillHeight: true
        //             clip: true
        //             // contentHeight: content.height
        //
        //             maximumFlickVelocity: 3000
        //             flickDeceleration: 1500
        //             boundsBehavior: Flickable.DragAndOvershootBounds
        //             boundsMovement: Flickable.FollowBoundsBehavior
        //
        //             rebound: Transition {
        //                 NumberAnimation {
        //                     properties: "x,y"
        //                     duration: 150
        //                     easing.bezierCurve: [0.85, 0, 0.15, 1]
        //                 }
        //             }
        //
        //             // ListView {
        //             //     clip: true
        //             //     spacing: 8
        //             //     model: NotificationService.trackedNotifications ?? []
        //             //     delegate: NotificationCard {}
        //             // }
        //         }
        //     }
        // }
    }
}
