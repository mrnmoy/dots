pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<string> wallpapers: []
    property string wallpapersDir: "~/Documents"
    // property alias colors: colors
    property var colors: JSON.parse(colorsFile.text())
    onColorsChanged: console.log("colors changed")

    FileView {
        id: colorsFile
        // path: "~/.cache/qs/colors.json"
        // path: "~/.config/themes/colors.json"
        // path: Qt.resolveUrl("~/.config/themes/colors.json")
        path: "/home/mrinmoy/.config/themes/colors.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
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
        // command: ["/bin/sh", "-c", `hyprctl hyprpaper wallpaper ", ${path}, cover"`]
        command: ["/bin/sh", "-c", `~/.config/quickshell/scripts/setwal.sh ${path}`]
    }
}
