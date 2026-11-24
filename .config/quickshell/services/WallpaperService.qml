pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

Singleton {
    id: root

    property list<string> wallpapers: []
    property string wallpapersDir: "~/Documents"
    property var colors: {
        var clrs = colorsFile.text().trim().split("\n");
        return {
            // primary: clrs[13]
            // primary: clrs[4]
            primary: clrs[11]
        };
    }

    FileView {
        id: colorsFile
        path: ("/home/mrinmoy/.config/themes/colors")
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    function set(path): void {
        setWallProc.path = path;
        setWallProc.running = true;
        if (Config.appearence.dynamicColors === "auto" || Config.appearence.dynamicColors === "wallpaper") {
            refreshColorsProc.path = path;
            refreshColorsProc.running = true;
        }
    }

    Process {
        id: fetchWallpapersProc
        running: true
        // command: ["/bin/sh", "-c", `find ${root.wallpapersDir} -type f -print0 | xargs -0 file --mime-type | grep -F 'image/' | cut -d ':' -f 1`]
        command: ["/bin/sh", "-c", `find ${root.wallpapersDir} -maxdepth 1 -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp"`]

        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = text.trim().split("\n");
                // console.log("wallpapers", JSON.stringify(root.wallpapers));
            }
        }
    }

    Process {
        id: setWallProc
        property string path: ""
        command: ["/bin/sh", "-c", `hyprctl hyprpaper wallpaper ", ${path}, cover"`]
    }

    Process {
        id: refreshColorsProc
        property string path: ""
        command: ["/bin/sh", "-c", `cwal -i ${path} -o /home/mrinmoy/.config/themes`]
    }
}
