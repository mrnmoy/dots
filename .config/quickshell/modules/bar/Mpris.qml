import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../../controls"
import "../../config"

Item {
    id: root
    implicitWidth: Math.min(Quickshell.screens[0].width / 3, 580)
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

            // FrameAnimation {
            //     running: root.player.isPlaying
            //     onTriggered: root.player.positionChanged()
            // }
            Timer {
                running: root.player.isPlaying
                interval: root.player.length / 100
                repeat: true
                onTriggered: root.player.positionChanged()
            }

            Item {
                implicitWidth: Math.min(parent.width - 16, title.implicitWidth)
                implicitHeight: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: title
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    text: "  " + root.player.trackTitle || "Unknown"
                    color: "#ffffff"
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                }
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
