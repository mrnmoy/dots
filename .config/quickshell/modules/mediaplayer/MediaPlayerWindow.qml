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
                    id: lyricsContainer
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
                        // preferredHighlightBegin: height / 2 - currentItem.height / 2
                        // preferredHighlightEnd: height / 2 + currentItem.height / 2
                        preferredHighlightBegin: height / 2 - 10
                        preferredHighlightEnd: height / 2 + 10
                        interactive: false
                        currentIndex: MprisService.currentLyricsIndex
                        spacing: 2
                        // highlightFollowsCurrentItem: true
                        // highlight: Rectangle {
                        //     Behavior on y {
                        //         NumberAnimation {
                        //             duration: 250
                        //         }
                        //     }
                        // }

                        delegate: Text {
                            id: card
                            required property var modelData
                            required property int index
                            readonly property int currentIndex: lyricsList.currentIndex

                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.text
                            color: "#ffffff"
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 250
                                }
                            }
                            // font.pixelSize: index === currentIndex ? 20 : (index === currentIndex + 1 || index === currentIndex - 1) ? 18 : (index === currentIndex + 2 || index === currentIndex - 2) ? 16 : (index === currentIndex + 3 || index === currentIndex - 3) ? 14 : 12

                            states: [
                                State {
                                    name: "primary"
                                    when: card.index === card.currentIndex

                                    PropertyChanges {
                                        target: card
                                        font.pixelSize: 20
                                        font.weight: Font.DemiBold
                                        // scale: 1
                                    }
                                },
                                State {
                                    name: "secondary"
                                    when: card.index === card.currentIndex + 1 || card.index === card.currentIndex - 1

                                    PropertyChanges {
                                        target: card
                                        font.pixelSize: 18
                                        opacity: 0.8
                                        // scale: 0.8
                                    }
                                },
                                State {
                                    name: "tertiary"
                                    when: card.index === card.currentIndex + 2 || card.index === card.currentIndex - 2

                                    PropertyChanges {
                                        target: card
                                        font.pixelSize: 16
                                        opacity: 0.6
                                        // scale: 0.6
                                    }
                                },
                                State {
                                    name: "others"
                                    when: card.index === card.currentIndex + 3 || card.index === card.currentIndex - 3

                                    PropertyChanges {
                                        target: card
                                        font.pixelSize: 14
                                        opacity: 0.4
                                        // scale: 0.4
                                    }
                                },
                                State {
                                    name: "etc"
                                    when: card.index >= card.currentIndex + 4 || card.index <= card.currentIndex - 4

                                    PropertyChanges {
                                        target: card
                                        font.pixelSize: 12
                                        opacity: 0
                                        // scale: 0.2
                                    }
                                }
                            ]
                        }

                        // delegate: Item {
                        //     id: lyricsItem
                        //     implicitWidth: parent.width
                        //     implicitHeight: lyricsText.height
                        //     required property var modelData
                        //     required property int index
                        //     readonly property int currentIndex: lyricsList.currentIndex
                        //
                        //     Text {
                        //         id: lyricsText
                        //         // horizontalAlignment: parent.horizontalCenter
                        //         anchors.horizontalCenter: parent.horizontalCenter
                        //         text: modelData.text
                        //         color: "#ffffff"
                        //         // font.pixelSize: index === currentIndex ? 20 : (index === currentIndex + 1 || index === currentIndex - 1) ? 18 : (index === currentIndex + 2 || index === currentIndex - 2) ? 16 : (index === currentIndex + 3 || index === currentIndex - 3) ? 14 : 12
                        //
                        //         states: [
                        //             State {
                        //                 name: "primary"
                        //                 when: lyricsItem.index === lyricsItem.currentIndex
                        //
                        //                 PropertyChanges {
                        //                     target: lyricsText
                        //                     font.pixelSize: 20
                        //                     font.weight: Font.DemiBold
                        //                 }
                        //             },
                        //             State {
                        //                 name: "secondary"
                        //                 when: lyricsItem.index === lyricsItem.currentIndex + 1 || lyricsItem.index === lyricsItem.currentIndex - 1
                        //
                        //                 PropertyChanges {
                        //                     target: lyricsText
                        //                     font.pixelSize: 18
                        //                     opacity: 0.8
                        //                 }
                        //             },
                        //             State {
                        //                 name: "tertiary"
                        //                 when: lyricsItem.index === lyricsItem.currentIndex + 2 || lyricsItem.index === lyricsItem.currentIndex - 2
                        //
                        //                 PropertyChanges {
                        //                     target: lyricsText
                        //                     font.pixelSize: 16
                        //                     opacity: 0.6
                        //                 }
                        //             },
                        //             State {
                        //                 name: "others"
                        //                 when: lyricsItem.index === lyricsItem.currentIndex + 3 || lyricsItem.index === lyricsItem.currentIndex - 3
                        //
                        //                 PropertyChanges {
                        //                     target: lyricsText
                        //                     font.pixelSize: 14
                        //                     opacity: 0.4
                        //                 }
                        //             },
                        //             State {
                        //                 name: "etc"
                        //                 when: lyricsItem.index >= lyricsItem.currentIndex + 4 || lyricsItem.index <= lyricsItem.currentIndex - 4
                        //
                        //                 PropertyChanges {
                        //                     target: lyricsText
                        //                     font.pixelSize: 12
                        //                     opacity: 0
                        //                 }
                        //             }
                        //         ]
                        //     }
                        // }
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
