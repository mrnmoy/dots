import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../../controls"

Slider {
    id: root
    implicitWidth: Math.min(Quickshell.screens[0].width / 3, 320)
    implicitHeight: 20
    enabled: player.canSeek
    visible: Mpris.players.values.length > 0

    readonly property MprisPlayer player: Mpris.players.values[0]

    from: 0
    to: player.length
    value: player.position
    stepSize: 1
    onMoved: if (player.canSeek)
        player.position = value

    FrameAnimation {
        running: root.player.isPlaying
        // running: root.player.playbackState === MprisPlaybackState.Playing
        onTriggered: root.player.positionChanged()
    }
    // Timer {
    //     running: root.player.playbackState == MprisPlaybackState.Playing
    //     interval: 1000
    //     repeat: true
    //     onTriggered: root.player.positionChanged()
    // }

    Text {
        anchors.centerIn: parent
        width: parent.width - 16
        text: "  " + root.player.trackTitle || "Unknown"
        color: "#ffffff"
        font.pixelSize: 12
        font.weight: Font.DemiBold
        elide: Text.ElideRight
    }
}
