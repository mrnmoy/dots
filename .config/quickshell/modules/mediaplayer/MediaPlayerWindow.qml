import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import "../../controls"
import "../../services"
import "../../config"

PanelWindow {
    id: root

    readonly property bool active: ShellState.mediaplayer
    readonly property MprisPlayer player: MprisService.player

    HyprlandFocusGrab {
        active: root.active
        windows: [root]
    }

    anchors {
        top: true
    }

    margins {
        top: active ? 0 : (-height + -34)
    }

    color: "transparent"
    implicitWidth: 640
    implicitHeight: 320

    screen: Quickshell.screens[0]
    exclusionMode: ExclusionMode.Normal

    function close(): void {
        ShellState.mediaplayer = false;
    }

    FocusScope {
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: root.close()
        Keys.onReturnPressed: {
            root.close();
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
                startY: 0

                PathArc {
                    radiusX: 20
                    radiusY: 20
                    x: 20
                    y: 20
                }
                PathLine {
                    x: 20
                    y: mask.height - 20
                }
                PathArc {
                    direction: PathArc.Counterclockwise
                    radiusX: 20
                    radiusY: 20
                    x: 40
                    y: mask.height
                }
                PathLine {
                    x: mask.width - 40
                    y: mask.height
                }
                PathArc {
                    direction: PathArc.Counterclockwise
                    radiusX: 20
                    radiusY: 20
                    x: mask.width - 20
                    y: mask.height - 20
                }
                PathLine {
                    x: mask.width - 20
                    y: 20
                }
                PathArc {
                    radiusX: 20
                    radiusY: 20
                    x: mask.width
                    y: 0
                }
                PathLine {
                    x: 0
                    y: 0
                }
            }
        }

        RowLayout {
            anchors {
                fill: background

                topMargin: 16
                leftMargin: 36
                rightMargin: 36
                bottomMargin: 16
            }
            spacing: 16

            Item {
                Layout.fillHeight: true
                implicitWidth: height

                TapHandler {
                    id: mouseArea
                    cursorShape: Qt.PointingHandCursor
                    onTapped: root.player.canRaise && root.player.raise()
                }

                Image {
                    id: artSource
                    visible: false
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: root.player.trackArtUrl
                }

                Rectangle {
                    id: artMask
                    anchors.fill: parent
                    radius: 20
                    visible: false
                    layer.enabled: true
                }

                MultiEffect {
                    id: art
                    visible: artSource.status === Image.Ready
                    anchors.fill: parent
                    source: artSource
                    maskSource: artMask
                    maskEnabled: true
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1.0
                }

                Rectangle {
                    anchors.fill: parent
                    visible: !art.visible
                    radius: 20
                    color: "#0fffffff"

                    Text {
                        anchors.centerIn: parent
                        text: "󰝚"
                        color: "#ffffff"
                        font.pixelSize: 40
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                // Layout.fillHeight: true

                Text {
                    Layout.alignment: Qt.AlignTop | Qt.AlignRight
                    // text: root.player.identity || "Unknown"
                    text: root.player.desktopEntry
                    // text: root.player.dbusName || "Unknown"
                    color: "#ffffff"
                    font.pixelSize: 10
                    font.weight: Font.Medium
                }

                Text {
                    text: root.player.trackTitle || "Unknown"
                    color: "#ffffff"
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Text {
                    text: root.player.trackArtist || "Unknown"
                    color: "#ffffff"
                    font.pixelSize: 10
                    font.weight: Font.Medium
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    IconButton {
                        // Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        anchors.top: parent.top
                        anchors.right: parent.right
                        icon: MprisService.lyricsEnabled ? "󰨖" : "󰨗"
                        onClicked: MprisService.lyricsEnabled = !MprisService.lyricsEnabled
                    }

                    ListView {
                        id: lyricsList
                        visible: MprisService.lyricsEnabled && !MprisService.loadingLyrics
                        model: MprisService.lyrics
                        // Layout.fillWidth: true
                        // Layout.fillHeight: true
                        anchors.fill: parent
                        clip: true
                        highlightRangeMode: ListView.StrictlyEnforceRange
                        preferredHighlightBegin: height / 2 - currentItem.height / 2
                        preferredHighlightEnd: height / 2 + currentItem.height / 2
                        interactive: false
                        currentIndex: MprisService.currentLyricsIndex
                        // Behavior on preferredHighlightBegin {
                        //     NumberAnimation {
                        //         duration: 500
                        //     }
                        // }
                        // Behavior on preferredHighlightEnd {
                        //     NumberAnimation {
                        //         duration: 500
                        //     }
                        // }

                        delegate: Text {
                            required property var modelData
                            required property int index
                            readonly property int currentIndex: lyricsList.currentIndex

                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.text
                            color: "#ffffff"
                            font.pixelSize: index === currentIndex ? 20 : (index === currentIndex + 1 || index === currentIndex - 1) ? 18 : (index === currentIndex + 2 || index === currentIndex - 2) ? 16 : (index === currentIndex + 3 || index === currentIndex - 3) ? 14 : 12
                        }
                    }
                }

                HorizontalSlider {
                    id: progress
                    visible: root.player.positionSupported
                    implicitHeight: 12
                    Layout.fillWidth: true
                    Layout.topMargin: 4
                    enabled: root.player.canSeek

                    from: 0
                    to: root.player.length
                    stepSize: 1

                    value: root.player.position
                    onMoved: {
                        root.player.seek(value);
                        // root.player.position = value;
                    }

                    Behavior on value {
                        NumberAnimation {
                            duration: Config.appearence.animationDuration || 500
                        }
                    }
                }
                RowLayout {
                    Text {
                        Layout.fillWidth: true
                        text: `${parseInt(progress.value / 60)}:${parseInt(progress.value % 60)}`
                        color: "#ffffff"
                        font.pixelSize: 10
                        font.weight: Font.Medium
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: `${parseInt(root.player.length / 60)}:${parseInt(root.player.length % 60)}`
                        color: "#ffffff"
                        font.pixelSize: 10
                        font.weight: Font.Medium
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                    IconButton {
                        icon: root.player.shuffle ? "󰒝" : "󰒞"
                        enabled: root.player.shuffleSupported
                        onClicked: root.player.shuffle = !root.player.shuffle
                    }
                    IconButton {
                        icon: "󰒮"
                        enabled: root.player.canGoPrevious
                        onClicked: root.player.previous()
                    }
                    IconButton {
                        icon: root.player.playbackState === MprisPlaybackState.Playing ? "" : ""
                        enabled: root.player.canTogglePlaying
                        onClicked: root.player.togglePlaying()
                        size: 32
                    }
                    IconButton {
                        icon: "󰒭"
                        enabled: root.player.canGoNext
                        onClicked: root.player.next()
                    }
                    IconButton {
                        icon: root.player.loopState === MprisLoopState.Track ? "󰑘" : root.player.loopState === MprisLoopState.Playlist ? "󰑖" : "󰑗"
                        enabled: root.player.loopSupported
                        onClicked: {
                            if (root.player.loopState === MprisLoopState.None)
                                root.player.loopState = MprisLoopState.Track;
                            else if (root.player.loopState === MprisLoopState.Track)
                                root.player.loopState = MprisLoopState.Playlist;
                            else
                                root.player.loopState = MprisLoopState.None;
                        }
                    }
                }
            }
        }
    }
}
