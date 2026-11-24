pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

Singleton {
    id: root

    property list<string> wallpapers: []
    property string wallpapersDir: "~/Documents"
    // property alias colors: colors
    // property var colors: JSON.parse(colorsFile.text())
    property var colors: undefined

    FileView {
        id: colorsFile
        // path: "~/.cache/qs/colors.json"
        // path: "~/.config/themes/colors.json"
        // path: ("/home/mrinmoy/.config/themes/colors.json")
        path: ("/home/mrinmoy/.config/themes/colors")
        // blockLoading: true
        watchChanges: true
        onFileChanged: reload()
        onTextChanged: {
            var clrs = text().trim().split("\n");
            root.colors = {
                primary: clrs[13]
            };
        }

        // adapter: JsonAdapter {}

        // onDataChanged: root.colorsChanged()
        // JsonAdapter {
        //     id: colors
        //     property string wallpaper: ""
        //     property string primary: ""
        //     property string secondary: ""
        //     property string tertiary: ""
        //     property string surface: ""
        //     property string oPrimary: ""
        //     property string oSecondary: ""
        //     property string oTertiary: ""
        //     property string oSurface: ""
        //     property string highlight: ""
        // }
    }

    function set(path): void {
        setWallProc.path = path;
        setWallProc.running = true;
        if (Config.appearence.dynamicColors === "auto" || Config.appearence.dynamicColors === "wallpaper") {
            fetchColorsProc.path = path;
            fetchColorsProc.running = true;
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
        // command: ["/bin/sh", "-c", `~/.config/quickshell/scripts/setwal.sh ${path}`]
        command: ["/bin/sh", "-c", `hyprctl hyprpaper wallpaper ", ${path}, cover"`]
    }

    Process {
        id: fetchColorsProc
        property string path: ""
        // command: ["/bin/sh", "-c", `palgen -i ${path} -c 24`]
        command: ["/bin/sh", "-c", `cwal -i ${path} -o /home/mrinmoy/.config/themes`]

        // stdout: StdioCollector {
        //     onStreamFinished: {
        //         var clrs = text.trim().split("\n");
        //
        //         if (clrs.length < 5) {
        //             console.warn("Failed getting colors from media art using palgen");
        //             return;
        //         }
        //
        //         root.colors = {
        //             primary: clrs[5],
        //             secondary: clrs[4],
        //             tertiary: clrs[3],
        //             // surface: '#00000001',
        //             surface: '#01000000',
        //             onPrimary: clrs[0],
        //             onSecondary: clrs[0],
        //             onTertiary: clrs[0],
        //             onSurface: clrs[0]
        //         };
        //     }
        // }
    }
}
