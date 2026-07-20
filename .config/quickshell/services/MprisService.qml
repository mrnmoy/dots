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
    property ListModel lyrics: ListModel {}

    onLyricsEnabledChanged: {
        if (lyricsEnabled && lyrics.count === 0)
            fetchLyrics();
    }

    function fetchLyrics(): void {
        // console.log("current player: ", JSON.stringify(root.player));
        console.log("fetching lyrics: ", lyricsProc.command);
        lyricsProc.running = true;
    }

    Connections {
        target: root.player

        function onPostTrackChanged() {
            if (root.lyricsEnabled)
                root.fetchLyrics();
        }
    }

    Process {
        id: lyricsProc
        command: ["/bin/sh", "-c", `curl "https://lrclib.net/api/get?artist_name=${encodeURI(root.player.trackArtist) + "&track_name=" + encodeURI(root.player.trackTitle) + "&album_name=" + encodeURI(root.player.trackAlbum) + "&duration=" + root.player.length}"`]

        stdout: StdioCollector {
            onStreamFinished: {
                // console.log(JSON.stringify(text));
                // console.log(JSON.parse(text).syncedLyrics);
                const lines = JSON.parse(text).syncedLyrics.split("\n");
                // console.log(lines[0]);
                // const times = lines[0].split(/\s+/)[0].match(/\[(.*?)\]/)[1].split(":");
                // console.log(times[0] * 60 + times[1]);
                for (var i = 0; i < lines.length; i++) {
                    const parts = lines[i].split(/\s+/);
                    const times = parts[0].match(/\[(.*?)\]/)[1].split(":");
                    root.lyrics.append({
                        time: times[0] * 60 + times[1],
                        text: parts[1]
                    });
                    console.log("time:", parts[0], "text:", parts[1]);
                }
                // root.lyricsChanged();
                // console.log("time:", root.lyrics.get(0).time, "text:", root.lyrics.get(0).text);
            }
        }
    }
}
