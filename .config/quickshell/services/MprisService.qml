pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values
    // readonly property MprisPlayer player: players[0]
    readonly property MprisPlayer player: players.find(plyr => plyr.isPlaying === true) || players[0]
    readonly property int playerIndex: players.indexOf(player) || 0

    property bool lyricsEnabled: false
    property bool lyricsAvailable: false
    property bool loadingLyrics: lyricsProc.running
    property ListModel lyrics: ListModel {}
    property int currentLyricsIndex: 0

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

    onLyricsChanged: {
        syncLyrics();
    }

    onLyricsEnabledChanged: {
        if (lyricsEnabled) {
            if (lyrics.count === 0)
                fetchLyrics();
            else
                syncLyrics();
        }
    }

    onCurrentLyricsIndexChanged: {
        if (lyrics.count > currentLyricsIndex + 1) {
            lyricsTimer.interval = lyrics.get(currentLyricsIndex + 1).time - player.position;
            lyricsTimer.reset();
        }
    }

    function fetchLyrics(): void {
        lyricsProc.running = true;
    }

    function syncLyrics(): void {
        for (var i = 0; i < lyrics.count; i++) {
            if (lyrics.get(i).time > player.position) {
                if (i > 0) {
                    currentLyricsIndex = i - 1;
                } else {
                    currentLyricsIndexChanged();
                }
                break;
            } else if (player.position > lyrics.get(lyrics.count - 1).time) {
                currentLyricsIndex = lyrics.count - 1;
                break;
            }
        }
    }

    Connections {
        target: root.player

        function onPostTrackChanged() {
            if (root.lyricsEnabled) {
                root.lyrics.clear();
                root.fetchLyrics();
            }
        }
    }

    FrameAnimation {
        id: lyricsTimer
        running: root.lyricsEnabled && root.player.isPlaying && root.lyrics.count > 0 && root.currentLyricsIndex !== root.lyrics.count - 1
        property real interval: 100
        onTriggered: {
            if (elapsedTime >= interval) {
                root.currentLyricsIndex = root.currentLyricsIndex + 1;
            }
        }
    }

    Process {
        id: lyricsProc
        command: ["/bin/sh", "-c", `curl "https://lrclib.net/api/get?artist_name=${encodeURI(root.player.trackArtist) + "&track_name=" + encodeURI(root.player.trackTitle) + "&album_name=" + encodeURI(root.player.trackAlbum) + "&duration=" + root.player.length}"`]

        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(text);
                if (!data.syncedLyrics) {
                    console.log("unalbe to fetch lyrics", lyricsProc.command);
                    root.lyricsAvailable = false;
                    return;
                }
                root.lyricsAvailable = true;
                const lines = data.syncedLyrics.split("\n");

                root.lyrics.append({
                    time: 0.00,
                    text: ""
                });
                for (var i = 0; i < lines.length; i++) {
                    const parts = lines[i].split(/ (.*)/);
                    const times = parts[0].match(/\[(.*?)\]/)[1].split(":");
                    root.lyrics.append({
                        time: parseInt(times[0] * 60) + parseFloat(times[1]),
                        text: parts[1]
                    });
                    // console.log("time:", parseInt(times[0] * 60) + parseFloat(times[1]), "text:", parts[1]);
                }
                root.lyricsChanged();
            }
        }
    }
}
