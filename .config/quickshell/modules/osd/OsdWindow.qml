import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../../components"
import "../../services"
import "../../controls"

PanelWindow {
    id: root

    anchors {
        right: true
    }

    color: "transparent"
    // implicitWidth: 360
    implicitWidth: content.width + content.anchors.leftMargin + content.anchors.rightMargin
    implicitHeight: Math.min(860, screen.height - (content.anchors.topMargin + content.anchors.bottomMargin)) + content.anchors.topMargin + content.anchors.bottomMargin

    screen: Quickshell.screens[0]
    exclusionMode: ExclusionMode.Normal

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
        running: root.visible
        interval: 2000
        onTriggered: if (!hoverHandler.hovered)
            root.visible = false
    }

    MultiEffect {
        source: background
        anchors.fill: background
        maskEnabled: true
        maskSource: mask

        // layer.smooth: true

        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
    }

    Rectangle {
        id: background
        anchors.fill: parent
        visible: false
        // smooth: true
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

            startX: mask.width
            startY: 0

            PathArc {
                radiusX: 20
                radiusY: 20
                x: mask.width - 20
                y: 20
            }
            PathLine {
                x: 20
                y: 20
            }
            PathArc {
                direction: PathArc.Counterclockwise
                radiusX: 20
                radiusY: 20
                x: 0
                y: 40
            }
            PathLine {
                x: 0
                y: mask.height - 40
            }
            PathArc {
                direction: PathArc.Counterclockwise
                radiusX: 20
                radiusY: 20
                x: 20
                y: mask.height - 20
            }
            PathLine {
                x: mask.width - 20
                y: mask.height - 20
            }
            PathArc {
                radiusX: 20
                radiusY: 20
                x: mask.width
                y: mask.height
            }
            PathLine {
                x: mask.width
                y: 0
            }
        }
    }

    RowLayout {
        id: content

        spacing: 8

        anchors {
            // fill: background
            top: parent.top
            bottom: parent.bottom
            left: parent.left

            topMargin: 36
            leftMargin: 16
            rightMargin: 16
            bottomMargin: 36
        }

        // Flickable {
        //     implicitWidth: background.width
        //     Layout.fillHeight: true
        //     contentWidth: parent.width
        //     contentHeight: content.height
        //     flickableDirection: Flickable.VerticalFlick
        //     clip: true
        //
        //     ColumnLayout {
        //         id: content
        //         implicitWidth: parent.width
        //         spacing: 8
        //     }
        // }

        ColumnLayout {
            // implicitWidth: 40
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            spacing: 8

            Rectangle {
                color: "#0fffffff"
                implicitWidth: parent.width
                implicitHeight: width
                radius: 20

                Text {
                    anchors.centerIn: parent
                    text: "󰣇"
                    color: "#ffffff"
                    font.pixelSize: 24
                }
            }

            Slider {
                orientation: Qt.Vertical
                implicitWidth: parent.width
                Layout.fillHeight: true
                icon: "󰕾"

                from: 0
                to: 1
                stepSize: 0.01
                value: AudioService.sinkVolume
                onMoved: AudioService.setSinkVolume(value)
            }
            Slider {
                orientation: Qt.Vertical
                Layout.fillHeight: true
                implicitWidth: parent.width
                icon: ""

                from: 0
                to: 1
                stepSize: 0.01
                value: AudioService.sourceVolume
                onMoved: AudioService.setSourceVolume(value)
            }
        }
    }
}
