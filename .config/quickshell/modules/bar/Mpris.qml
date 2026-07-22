import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../../controls"
import "../../config"
import "../../services"

Item {
    id: root
    implicitWidth: Math.min(Quickshell.screens[0].width / 3, 540)
    implicitHeight: 20

    property MprisPlayer player: Mpris.players.values[0] || null

    Component {
        id: sliderComp

        HorizontalSlider {
            id: slider
            enabled: root.player.canSeek

            // required property MprisPlayer player

            from: 0
            to: root.player.length
            value: root.player.position
            stepSize: 1
            onMoved: if (root.player.canSeek) {
                root.player.position = value;
            }

            Behavior on value {
                NumberAnimation {
                    duration: Config.appearence.animationDuration || 500
                }
            }

            Item {
                visible: lyrics
                implicitWidth: Math.min(parent.width - 16, visibleText.implicitWidth)
                // implicitWidth: Math.min(parent.width - 16, lyrics.visible ? lyrics.implicitWidth : title.implicitWidth)
                // implicitHeight: parent.height
                implicitHeight: visibleText.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                readonly property string title: "  " + root.player.trackTitle || "Unknown"
                readonly property string lyric: MprisService.lyrics.get(MprisService.currentLyricsIndex).text || ""
                readonly property string currentText: MprisService.lyricsEnabled && lyric !== "" ? lyric : title

                Text {
                    id: visibleText
                    width: parent.width
                    // anchors.verticalCenter: parent.verticalCenter
                    text: parent.currentText
                    color: "#ffffff"
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                }

                // Text {
                //     id: title
                //     visible: !lyrics.visible
                //     width: parent.width
                //     anchors.verticalCenter: parent.verticalCenter
                //     text: "  " + root.player.trackTitle || "Unknown"
                //     color: "#ffffff"
                //     font.pixelSize: 12
                //     font.weight: Font.DemiBold
                //     elide: Text.ElideRight
                // }

                // Text {
                //     id: lyrics
                //     visible: MprisService.lyricsEnabled && !ShellState.mediaplayer // || text !== ""
                //     width: parent.width
                //     anchors.verticalCenter: parent.verticalCenter
                //     text: MprisService.lyrics.get(MprisService.currentLyricsIndex).text || ""
                //     color: "#ffffff"
                //     font.pixelSize: 12
                //     font.weight: Font.DemiBold
                //     elide: Text.ElideRight
                // }
            }
        }
    }

    Loader {
        anchors.fill: parent
        active: root.player !== null
        asynchronous: true
        sourceComponent: sliderComp
        // property MprisPlayer player: root.player
    }
}
