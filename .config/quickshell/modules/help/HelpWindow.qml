import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import "../../controls"
import "../../services"

PanelWindow {
    id: root

    readonly property bool active: ShellState.help

    HyprlandFocusGrab {
        active: root.active
        windows: [root]
    }

    anchors {
        bottom: true
    }

    margins {
        bottom: active ? 0 : -height
    }

    color: "transparent"
    implicitWidth: Math.min(540, screen.width - 40)
    implicitHeight: Math.min(640, screen.height - 40)

    screen: Quickshell.screens[0]
    exclusionMode: ExclusionMode.Normal
    // WlrLayershell.keyboardFocus: active ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    property string query: ""

    function launch(): void {
    }

    function close(): void {
        ShellState.launcher = false;
        root.query = "";
    }

    FocusScope {
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: root.close()
        Keys.onDownPressed: list.incrementCurrentIndex()
        Keys.onUpPressed: list.decrementCurrentIndex()
        Keys.onReturnPressed: {
            root.launch();
        }

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
                root.close()
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
            anchors {
                fill: background

                topMargin: 16
                leftMargin: 36
                rightMargin: 36
                bottomMargin: 8
            }
            spacing: 16

            Rectangle {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
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
                    TextFieldBase {
                        focus: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        font.pixelSize: 20
                        placeholderText: "Search"
                        text: root.query
                        onTextChanged: root.query = text
                    }
                }
            }

            Loader {
                active: root.active
                asynchronous: true
                focus: true
                sourceComponent: HelpList {}
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
