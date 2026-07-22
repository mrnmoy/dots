import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris
import "../../controls"
import "../../services"
import "../../config"

RowLayout {
    id: card
    spacing: 16

    required property MprisPlayer modelData
    required property int index

    Item {
        Layout.fillHeight: true
        implicitWidth: height

        TapHandler {
            id: mouseArea
            cursorShape: Qt.PointingHandCursor
            onTapped: card.modelData.canRaise && card.modelData.raise()
        }

        Image {
            id: artSource
            visible: false
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: card.modelData.trackArtUrl
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
            // text: card.modelData.identity || "Unknown"
            text: card.modelData.desktopEntry
            // text: card.modelData.dbusName || "Unknown"
            color: "#ffffff"
            font.pixelSize: 10
            font.weight: Font.Medium
        }

        Text {
            text: card.modelData.trackTitle || "Unknown"
            color: "#ffffff"
            font.pixelSize: 12
            font.weight: Font.DemiBold
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        Text {
            text: card.modelData.trackArtist || "Unknown"
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

            Text {
                id: lyricsStatusText
                anchors.centerIn: parent
                visible: MprisService.lyricsEnabled && !MprisService.lyricsAvailable
                text: MprisService.loadingLyrics ? "Loading lyrics..." : "Lyrics unavailable"
                color: "#ffffff"
                font.pixelSize: 12
                font.weight: Font.DemiBold
                elide: Text.ElideRight
                lineHeight: 0
            }

            ListView {
                id: lyricsList
                visible: !lyricsStatusText.visible
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
            visible: card.modelData.positionSupported
            implicitHeight: 12
            Layout.fillWidth: true
            Layout.topMargin: 4
            enabled: card.modelData.canSeek

            from: 0
            to: card.modelData.length
            stepSize: 1

            value: card.modelData.position
            onMoved: {
                card.modelData.seek(value);
                // card.modelData.position = value;
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
                text: `${parseInt(card.modelData.length / 60)}:${parseInt(card.modelData.length % 60)}`
                color: "#ffffff"
                font.pixelSize: 10
                font.weight: Font.Medium
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            IconButton {
                icon: card.modelData.shuffle ? "󰒝" : "󰒞"
                enabled: card.modelData.shuffleSupported
                onClicked: card.modelData.shuffle = !card.modelData.shuffle
            }
            IconButton {
                icon: "󰒮"
                enabled: card.modelData.canGoPrevious
                onClicked: card.modelData.previous()
            }
            IconButton {
                icon: card.modelData.playbackState === MprisPlaybackState.Playing ? "" : ""
                enabled: card.modelData.canTogglePlaying
                onClicked: card.modelData.togglePlaying()
                size: 32
            }
            IconButton {
                icon: "󰒭"
                enabled: card.modelData.canGoNext
                onClicked: card.modelData.next()
            }
            IconButton {
                icon: card.modelData.loopState === MprisLoopState.Track ? "󰑘" : card.modelData.loopState === MprisLoopState.Playlist ? "󰑖" : "󰑗"
                enabled: card.modelData.loopSupported
                onClicked: {
                    if (card.modelData.loopState === MprisLoopState.None)
                        card.modelData.loopState = MprisLoopState.Track;
                    else if (card.modelData.loopState === MprisLoopState.Track)
                        card.modelData.loopState = MprisLoopState.Playlist;
                    else
                        card.modelData.loopState = MprisLoopState.None;
                }
            }
        }
    }
}
