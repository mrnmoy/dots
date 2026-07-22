pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer player: players[0]
    property bool lyricsEnabled: false
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
            // lyricsTimer.running = true;
            console.log("next line interval", lyricsTimer.interval);
        }
    }

    function fetchLyrics(): void {
        lyricsProc.running = true;
        // console.log("fetchLyrics()");
        // for (var i = 0; i < 10; i++) {
        //     lyrics.append({
        //         time: i * 20.0,
        //         text: `line ${i}`
        //     });
        // }
        // lyricsChanged();
    }

    function syncLyrics(): void {
        for (var i = 0; i < lyrics.count; i++) {
            // console.log("time", lyrics.get(i).time, "position", player.position);
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

        function onTrackChanged() {
            console.log("postTrackChanged()");
            if (root.lyricsEnabled) {
                if (root.lyrics.count === 0)
                    root.fetchLyrics();

                root.syncLyrics();
            }
        }
    }

    FrameAnimation {
        id: lyricsTimer
        running: root.lyricsEnabled && root.player.isPlaying && root.lyrics.count > 0 && root.currentLyricsIndex !== root.lyrics.count - 1
        property real interval: 100
        onTriggered: {
            // console.log("elapsedTime", elapsedTime);
            if (elapsedTime >= interval) {
                root.currentLyricsIndex = root.currentLyricsIndex + 1;
            }
        }
    }
    // Timer {
    //     id: lyricsTimer
    //     repeat: true
    //     running: false
    //     triggeredOnStart: false
    //     onTriggered: {
    //         root.currentLyricsIndex = root.currentLyricsIndex + 1;
    //         running = false;
    //     }
    // }

    Process {
        id: lyricsProc
        command: ["/bin/sh", "-c", `curl "https://lrclib.net/api/get?artist_name=${encodeURI(root.player.trackArtist) + "&track_name=" + encodeURI(root.player.trackTitle) + "&album_name=" + encodeURI(root.player.trackAlbum) + "&duration=" + root.player.length}"`]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = JSON.parse(text).syncedLyrics.split("\n");
                console.log(lines);
                for (var i = 0; i < lines.length; i++) {
                    const parts = lines[i].split(/ (.*)/);
                    const times = parts[0].match(/\[(.*?)\]/)[1].split(":");
                    root.lyrics.append({
                        time: times[0] * 60 + times[1],
                        text: parts[1]
                    });
                    root.lyricsChanged();
                    // console.log("time:", times[0] * 60 + times[1], "text:", parts[1]);
                }
            }
        }
    }
}
