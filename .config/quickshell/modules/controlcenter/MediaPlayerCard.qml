import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris
import "../../controls"

Rectangle {
    id: root

    required property MprisPlayer modelData
    required property int index

    implicitWidth: parent.width
    implicitHeight: 100
    radius: 20
    color: "#0fffffff"

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Item {
            Layout.fillHeight: true
            implicitWidth: height

            Image {
                id: artSource
                visible: false
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: root.modelData.trackArtUrl
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

        // Rectangle {
        //     Layout.fillHeight: true
        //     implicitWidth: height
        //     color: "#0fffffff"
        //     radius: 20
        //     clip: true
        //
        //     Image {
        //         id: art
        //         anchors.fill: parent
        //         fillMode: Image.PreserveAspectCrop
        //         source: root.modelData.trackArtUrl
        //         visible: status === Image.Ready
        //     }
        //
        //     Text {
        //         anchors.centerIn: parent
        //         visible: !art.visible
        //         text: "󰝚"
        //         color: "#ffffff"
        //         font.pixelSize: 40
        //     }
        // }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 8
            spacing: 0

            ColumnLayout {
                spacing: 0

                Text {
                    text: root.modelData.trackTitle || "Unknown"
                    color: "#ffffff"
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                RowLayout {
                    Text {
                        text: root.modelData.trackArtist || "Unknown"
                        color: "#ffffff"
                        font.pixelSize: 10
                        font.weight: Font.Medium
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Text {
                        // text: root.modelData.identity || "Unknown"
                        text: root.modelData.desktopEntry
                        // text: root.modelData.dbusName || "Unknown"
                        color: "#ffffff"
                        font.pixelSize: 10
                        font.weight: Font.Medium
                    }
                }
            }

            Slider {
                visible: root.modelData.positionSupported
                implicitHeight: 12
                Layout.fillWidth: true
                Layout.topMargin: 4
                opacity: !root.modelData.canSeek ? 0.5 : 1

                from: 0
                to: root.modelData.length
                stepSize: 1

                value: root.modelData.position
                onMoved: if (root.modelData.canSeek)
                    root.modelData.position = value

                // Text {
                //     text: root.modelData.position
                //     anchors.verticalCenter: parent.verticalCenter
                //     color: "#ffffff"
                //     font.pixelSize: 10
                //     font.weight: Font.Medium
                //     x: 2
                // }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                IconButton {
                    icon: root.modelData.shuffle ? "󰒝" : "󰒞"
                    enabled: root.modelData.shuffleSupported
                    onClicked: root.modelData.shuffle = !root.modelData.shuffle
                }
                IconButton {
                    icon: "󰒮"
                    enabled: root.modelData.canGoPrevious
                    onClicked: root.modelData.previous()
                }
                IconButton {
                    icon: root.modelData.playbackState === MprisPlaybackState.Playing ? "" : ""
                    enabled: root.modelData.canTogglePlaying
                    onClicked: root.modelData.togglePlaying()
                }
                IconButton {
                    icon: "󰒭"
                    enabled: root.modelData.canGoNext
                    onClicked: root.modelData.next()
                }
                IconButton {
                    icon: root.modelData.loopState === MprisLoopState.Track ? "󰑘" : root.modelData.loopState === MprisLoopState.Playlist ? "󰑖" : "󰑗"
                    enabled: root.modelData.loopSupported
                    onClicked: {
                        if (root.modelData.loopState === MprisLoopState.None)
                            root.modelData.loopState = MprisLoopState.Track;
                        else if (root.modelData.loopState === MprisLoopState.Track)
                            root.modelData.loopState = MprisLoopState.Playlist;
                        else
                            root.modelData.loopState = MprisLoopState.None;
                    }
                }
            }
        }
    }
}
