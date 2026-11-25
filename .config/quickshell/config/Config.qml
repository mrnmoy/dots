pragma Singleton

import QtQuick
import Quickshell
import "../services"

Singleton {
    id: root

    property var launcher: ({
            favourites: ["Alacritty", "Zen Browser", "thunar",]
        })

    property var onScreenNotification: ({
            maxLength: 3,
            timeout: 5000
        })

    property var appearence: ({
            theme: "auto" // "auto" | "light" | "dark"
            ,
            dynamicColors: "auto" // "auto" | "wallpaper" | "media" | "none"
            ,
            dynamicWallpaper: true,
            // wallpaperBlur:, 20 // TODO
            animationDuration: 250,
            timeout: 0
        })

    property var media: ({
            lyricsEnabled: true,
            blacklist: ["Mozilla zen"]
        })

    property string wallpapersDir: "Desktop"
}
