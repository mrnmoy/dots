import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
// import qs.config
import "../../config"
import "../../components"

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

    property string query: ""
    property int selectedIndex: 0

    readonly property var favouriteApps: {
        const favourites = Config.launcher.favourites ?? [];
        const apps = DesktopEntries.applications.values ?? [];
        return favourites.map(id => apps.find(entry => entry.id === id || entry.name === id));
    }
    readonly property var visibleEntries: {
        const q = query.trim();

        if (!q.length && favouriteApps.length > 0)
            return favouriteApps.slice(0, Config.launcher.maxResults);

        return DesktopEntries.applications.values ?? [];
    }

    FocusScope {
        id: panelContent
        anchors.fill: parent

        transformOrigin: Item.Bottom
        scale: visible ? 1.0 : 0.5
        opacity: visible ? 1.0 : 0.0

        focus: true
        Keys.onEscapePressed: root.visible = false
        Keys.onDownPressed: root.selectedIndex = Math.min(root.selectedIndex + 1, root.visibleEntries.length - 1)
        Keys.onUpPressed: root.selectedIndex = Math.max(root.selectedIndex - 1, 0)
        Keys.onEnterPressed: root.visibleEntries[root.selectedIndex].execute()

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

                // RowLayout {
                //     anchors.fill: parent
                //     Layout.leftMargin: 16
                //     Layout.rightMargin: 16
                //     spacing: 16
                //
                //     Text {
                //         text: "󰣇"
                //         font.pixelSize: 20
                //         font.weight: Font.Black
                //         color: "#ffffff"
                //         Layout.leftMargin: 16
                //     }
                //     // TextField {
                //     //     font.family: "Inter"
                //     //     font.pixelSize: 16
                //     //     font.weight: Font.Medium
                //     //     color: "#f1f1f1"
                //     // }
                // }
                SearchBar {}
            }

            Flickable {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(320, list.implicitHeight + 16)
                clip: true
                contentWidth: width
                contentHeight: list.implicitHeight

                maximumFlickVelocity: 3000
                flickDeceleration: 1500
                boundsBehavior: Flickable.StopAtBounds
                // boundsBehavior: Flickable.DragAndOvershootBounds
                boundsMovement: Flickable.FollowBoundsBehavior

                rebound: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        duration: 150
                        easing.bezierCurve: [0.85, 0, 0.15, 1]
                    }
                }

                Column {
                    id: list
                    // implicitWidth: parent.width
                    spacing: 8

                    Repeater {
                        model: root.visibleEntries

                        Rectangle {
                            id: card

                            required property var modelData
                            required property int index

                            width: parent.width
                            height: 60
                            radius: 20
                            color: "#0fffffff"

                            HoverHandler {
                                id: hovered
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 8

                                Rectangle {
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 40
                                    radius: 20
                                    color: "#0fffffff"

                                    Text {
                                        anchors.centerIn: parent
                                        text: card.modelData.glyph ?? card.modelData.name.slice(0, 1).toUpperCase()
                                        font.family: "Inter"
                                        font.pixelSize: 20
                                        font.weight: Font.DemiBold
                                        color: "#ffffff"
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2

                                    Text {
                                        Layout.fillWidth: true
                                        text: card.modelData.name ?? "Unknown"
                                        font.family: "Inter"
                                        font.pixelSize: 16
                                        font.weight: Font.Medium
                                        color: "#ffffff"
                                        elide: Text.ElideRight
                                    }

                                    Text {
                                        Layout.fillWidth: true
                                        text: card.modelData.comment || card.modelData.genericName || card.modelData.execString || "Launch"
                                        font.family: "Inter"
                                        font.pixelSize: 12
                                        color: "#ffffff"
                                        elide: Text.ElideRight
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onEntered: root.selectedIndex = card.index
                                onClicked: card.modelData.execute()
                            }
                        }
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                visible: root.visibleEntries === 0
                text: "No application found"
                horizontalAlignment: Text.AlignHCenter
                font.family: "Inter"
                font.pixelSize: 12
                color: "#ffffff"
            }
        }
    }
}
