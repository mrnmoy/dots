pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
import "../config"

Singleton {
    id: root

    property list<string> wallpapers: []
    readonly property list<string> extensions: ["jpg", "jpeg", "png", "webp", "avif", "bmp", "svg"] // TODO: videos
    readonly property bool loading: thumbGenProc.running

    function load(): void {
        thumbGenProc.running = true;
    }

    // FolderListModel {
    //     id: folderModel
    //     // folder: "/home/mrinmoy/Desktop/"
    //     // folder: Qt.resolvedUrl(`${Directories.pictures}`)
    //     folder: Qt.resolvedUrl("/home/mrinmoy/Desktop")
    //     // nameFilters: ["*.jpg", "*.jpeg", "*.webp"]
    //     nameFilters: root.extensions.map(ext => `*.${ext}`)
    //     showDotAndDotDot: false
    //     // rootFolder: true
    //     showDirs: true
    //     showFiles: true
    //     sortField: FolderListModel.Time
    //     caseSensitive: true
    //     onCountChanged: {
    //         console.log("wallpapers count changed", count);
    //         root.wallpapers = [];
    //         for (let i = 0; i < folderModel.count; i++) {
    //             const path = folderModel.get(i, "filePath");
    //             console.log("path: ", path);
    //         }
    //     }
    // }

    function setWallpaper(path): void {
        setWallpaperProc.path = path;
        setWallpaperProc.running = true;
        if (Config.appearence.dynamicColors === "auto" || Config.appearence.dynamicColors === "wallpaper") {
            ThemeService.refreshColors(path);
        }
    }

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
        id: setWallpaperProc
        property string path: ""
        command: ["/bin/sh", "-c", `hyprctl hyprpaper wallpaper ", ${path}, cover"`]
        // command: ["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/set-wallpaper.sh ${path} ${Config.appearence.dynamicWallpaper && "tmp"}`]
    }

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
