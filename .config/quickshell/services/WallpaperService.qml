pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

Singleton {
    id: root

    property list<string> wallpapers: []
    readonly property list<string> extensions: ["jpg", "jpeg", "png", "webp", "avif", "bmp", "svg"] // TODO: videos
    readonly property bool loading: thumbGenProc.running

    function load(): void {
        thumbGenProc.running = true;
    }

    // function set(path, wallpaper = true, tmp = false): void {
    //     Quickshell.execDetached(["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/set-wallpaper-colors.sh -i ${path} -m dark${Config.appearence.dynamicColors !== "none" && " -c"}${wallpaper && "-w"}${tmp && "-t"}`]);
    // }

    // Process {
    //     id: fetchWallpapersProc
    //     running: false
    //     // command: ["/bin/sh", "-c", `find ${root.wallpapersDir} -type f -print0 | xargs -0 file --mime-type | grep -F 'image/' | cut -d ':' -f 1`]
    //     command: ["/bin/sh", "-c", `find ${Config.wallpapersDir} -maxdepth 1 -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp"`]
    //
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             root.wallpapers = text.trim().split("\n");
    //             console.log("wallpapers", JSON.stringify(root.wallpapers));
    //         }
    //     }
    // }

    Process {
        id: thumbGenProc
        running: true
        command: ["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/generate-thumbnails.sh`]

        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = text.trim().split("\n");
                console.log("wallpapers", JSON.stringify(root.wallpapers));
            }
        }
    }
}
