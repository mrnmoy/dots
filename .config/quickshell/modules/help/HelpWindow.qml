import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../components"
import "../../services"

PanelWindow {
    id: root
    visible: ShellState.help

    anchors.top: true
    exclusionMode: ExclusionMode.Ignore

    implicitWidth: screen.width
    implicitHeight: 56
    color: "transparent"

    screen: Quickshell.screens[0]

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

        // preferredRendererType: Shape.CurveRenderer
        // preferredRendererType: Shape.SoftwareRenderer

        ShapePath {
            strokeColor: "transparent"

            startX: 0
            startY: 0

            PathLine {
                x: 0
                y: mask.height
            }
            PathArc {
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
            PathLine {
                x: 0
                y: 0
            }
        }
    }
}
